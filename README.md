# bh-coding-ex

[Live link](http://ec2-18-235-169-134.compute-1.amazonaws.com)

### Problem

Currently, clinicians at Blueprint Health can manually choose and assign assessments to patients, sometimes having to review each assessment before assigning it. In order to improve a clinician's ability to provide the right care, Blueprint Health has contracted me to provide them a prototype of an innovative tool that allows a patient to take a diagnostic screener (a special assessment that covers a wide variety of symptoms) which then scores the patient's response to this screener based on specific criteria they have provided. After performing calculations of the patient's scores, the prototype should automatically assign assessments to the patient based on their symptoms.

### Solution

To solve this problem, I built the prototype with Flutter on the frontend, with a Ruby on Rails API on the backend. The frontend on start makes a request to the Rails API to fetch the diagnostic screener, and display the questions. When the patient completes the screener, their answers are sent back to the API in order to store them, calculate the scores for their symptoms, and then respond back with the assessment results.

### Reasoning for Technical Decisions

I went with Flutter for the frontend because of great developer experience (speed, UI, UX) and it's what I've been using the most over the past year-and-a-half. I used a Ruby-on-Rails API on the backend for the client/server resquest-response cycle for the same reasons I picked Flutter. Great developer experience, and it's what I've been using the most over the past year-and-a-half. I could've used Typescript/React to replicate Blueprint Health's tech stack but it would've slowed me down because it's been 2 years since I've consistently built anything using those languages/frameworks. Made more sense to use the right tools for the job! For storage, I stored the actual answers in a Postgres DB, while storing the domain mapping and diagnostic screener as JSON files in the file system. This made it less opinionated and much simpler to focus on actually spending time coding the solution to the problem.

When working on the UI and and having to display the questions one-at-a-time on the page and advancing the user when the tapped an answer to the question, I kind of went with a linked-list approach, where all the questions were represented as modeled objects containing their necessary data (question, selected answer) while holding pointers to the next and previous questions where applicable. This made it very easy for me to build a clean solution that was simple and easy to implement.

### How would I deploy this as a true production app?

As a _true_ production app, I would dockerize the frontend and dockerize the backend using docker-compose to allow the deployment process to always be the same while allowing packaging/deployment of either to be independent of each other. Depending on how much automation we want in the deployment process we for the backend, Jenkins can be used to orchestrate the CI/CD pipeline with a combination of Terraform to provision the infrastructure if needed. The frontend could be hosted on Netlify, Vercel, AWS. To ensure the application is highly available and performs well, our application server(s) would auto-scale using AWS's fully-managed auto-scaling feature and these servers would sit behind a load-balancer which would direct traffic to our servers. The application would be secured by implementing user authentication and user authorization through session tokens or JWTs to make sure only the right users are allowed to access the application. For security, we'd also make sure HTTPS for encryption is anabled on the web app and sensitive information like PHI isn't surfaced in the logs. In order to make it easier to troubleshoot problems while running live, logging will be implemented of course (user actions, log levels for efficient filtering, etc.) but also allowing ourselves to be able to SSH onto the instances themselves to read the logs in real time, and also documenting some of these steps so other engineers can follow these steps for faster debugging. 

### Tradeoffs

I didn't spend time on styling but because I used Flutter, which uses Material UI, it still didn't look too bad! For the data model, I only created an entity to store the `value` and `question_id` for the answers without including a `Patient` or `Diagnostic Screen` entity and their respective foreign keys as I felt they weren't needed in order to fullfil the requirements of the coding exercise. I could've stored all the answers to the diagnostic assessment as a JSON blob but opted to store each answer individually because it made more sense to me to put some db level constraints to make sure each submitted `value` for an answer passed the requirements of being between `0 and 4`. This way bulk transactions straight to the db are caught and not only through the api. I also didn't add a button for being able to go back and forth between completed questions to change answers. When hosting, I deployed both the frontend and the backend on the same server using nginx. This allowed me to host it much faster and not worry about spending too much time trying to host them seperately.

Now, if I were to spend additional time on the project, to start, I wouldn't host them both on the same server or dockerize them together, because if the server goes down, both the frontend and backend are now offline or anytime changes are made to the frontend, the backend also has to be deployed again and vice versa. I would also spend more time on the data model to make it more robust for a client-facing web application, and I would spend more time on the UI/UX of the user journey making it more immersive and smooth for patients.

### Personal Links

I love using my creativity to solve real world problems that helps improve lives of other people. I built an app to combat the ongoing loneliness epidiemic [looknforgroup](https://looknforgroup.com) to allow people to find things to do with other people. I am also now working on an app that uses the Gemini AI/LLMs/Embeddings to help people ask real world questions regarding the laws and statutes in each state relating to things they may encounter in their daily lives.

[Resume](https://docs.google.com/document/d/1IycWE34A_SiGJEde0UXHNQcHTJbqCPLC59P7xDHsbhg/edit?usp=sharing)

