# builder is a "phase"
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# only one FROM allowed per phase, so this signifies a new phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# ^ copy the result from the 'builder' phase into the default nginx dir
# note: we don't have to start nginx ... that's the default cmd for the nginx container
# run like so:
#   ghost@theMachine frontend % docker run -p 8080:80 580ed7654c0d29