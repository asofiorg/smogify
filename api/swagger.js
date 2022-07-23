const schema = {
  swagger: "2.0",
  tags: [
    {
      name: "Reports",
      description: "Handle smog reports from users",
    },
    {
      name: "Users",
      description: "Handle users related queries",
    },
  ],
  info: {
    title: "Smogify API",
    description:
      "The API documentation for the Smogify API, project submitted for Uber Global Hackathon",
    version: "1.0.0",
  },
  schemes: ["https"],
  consumes: ["application/json"],
  produces: ["application/json"],
  paths: {
    "/reports": {
      get: {
        description: "Get all reports",
        tags: ["Reports"],
        produces: ["application/json"],
        responses: {
          200: {
            description: "A list of reports",
            schema: {
              type: "array",
              items: {
                type: "object",
                properties: {
                  id: {
                    type: "string",
                    description: "The unique identifier for the report",
                  },
                  uuid: {
                    type: "string",
                    description: "The unique identifier for the reporter",
                  },
                  latitude: {
                    type: "number",
                    format: "float",
                    description: "The latitude of the report",
                  },
                  longitude: {
                    type: "number",
                    format: "float",
                    description: "The longitude of the report",
                  },
                  smog: {
                    type: "boolean",
                    description: "Whether the report is smoggy or not",
                  },
                  createdAt: {
                    type: "string",
                    format: "date-time",
                    description: "The date and time the report was created",
                  },
                },
              },
            },
          },
        },
      },
      post: {
        description: "Create a new report",
        tags: ["Reports"],
        produces: ["application/json"],
        parameters: [
          {
            name: "body",
            in: "body",
            description: "The report to create",
            required: true,
            schema: {
              type: "object",
              properties: {
                uuid: {
                  type: "string",
                  description: "The unique identifier for the reporter",
                },
                latitude: {
                  type: "number",
                  format: "float",
                  description: "The latitude of the report",
                },
                longitude: {
                  type: "number",
                  format: "float",
                  description: "The longitude of the report",
                },
                smog: {
                  type: "boolean",
                  description: "Whether the report is smoggy or not",
                },
              },
            },
          },
        ],
        responses: {
          200: {
            description: "The created report",
            schema: {
              type: "object",
              properties: {
                id: {
                  type: "string",
                  description: "The unique identifier for the report",
                },
                uuid: {
                  type: "string",
                  description: "The unique identifier for the reporter",
                },
                latitude: {
                  type: "number",
                  format: "float",
                  description: "The latitude of the report",
                },
                longitude: {
                  type: "number",
                  format: "float",
                  description: "The longitude of the report",
                },
                smog: {
                  type: "boolean",
                  description: "Whether the report is smoggy or not",
                },
                createdAt: {
                  type: "string",
                  format: "date-time",
                  description: "The date and time the report was created",
                },
              },
            },
          },
        },
      },
    },
    "/user": {
      post: {
        description: "Create a new user",
        tags: ["Users"],
        produces: ["application/json"],
        parameters: [
          {
            name: "body",
            in: "body",
            description: "The user to create",
            required: true,
            schema: {
              type: "object",
              properties: {
                uuid: {
                  type: "string",
                  description: "The unique identifier for the user",
                },
                name: {
                  type: "string",
                  description: "The name of the user",
                },
              },
            },
          },
        ],
        responses: {
          500: {
            description: "An error occurred",
            schema: {
              type: "object",
              properties: {
                e: {
                  type: "string",
                  description: "The error message",
                },
              },
            },
          },
          200: {
            description: "The created user",
            schema: {
              type: "object",
              properties: {
                id: {
                  type: "string",
                  description: "The unique identifier for the user",
                },
                uuid: {
                  type: "string",
                  description: "The unique identifier for the user",
                },
                name: {
                  type: "string",
                  description: "The name of the user",
                },
                createdAt: {
                  type: "string",
                  format: "date-time",
                  description: "The date and time the user was created",
                },
              },
            },
          },
        },
      },
    },
    "/user/{uuid}": {
      get: {
        description: "Get a user by uuid",
        tags: ["Users"],
        produces: ["application/json"],
        parameters: [
          {
            name: "uuid",
            in: "path",
            description: "The unique identifier for the user",
            required: true,
            type: "string",
          },
        ],
        responses: {
          500: {
            description: "An error occurred",
            schema: {
              type: "object",
              properties: {
                e: {
                  type: "string",
                  description: "The error message",
                },
              },
            },
          },
          200: {
            description: "The user",
            schema: {
              type: "object",
              properties: {
                id: {
                  type: "string",
                  description: "The unique identifier for the user",
                },
                name: {
                  type: "string",
                  description: "The name of the user",
                },
                uuid: {
                  type: "string",
                  description: "The unique identifier for the user",
                },
                createdAt: {
                  type: "string",
                  format: "date-time",
                  description: "The date and time the user was created",
                },
              },
            },
          },
        },
      },

    }
  },
};

export default schema;
