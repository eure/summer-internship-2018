package main

import (
        "fmt"
            "github.com/andygrunwald/go-trending"
                "log"
            )

            func main() {
                    trend := trending.NewTrending()

                        // Show projects of today
                            projects, err := trend.GetProjects(trending.TimeToday, "")
                                if err != nil {
                                            log.Fatal(err)
                                                }
                                                    for index, project := range projects {
                                                                no := index + 1
                                                                        if len(project.Language) > 0 {
                                                                                        fmt.Printf("%d: %s (written in %s with %d Åö )\n", no, project.Name, project.Language, project.Stars)
                                                                                                } else {
                                                                                                                fmt.Printf("%d: %s (with %d Åö )\n", no, project.Name, project.Stars)
                                                                                                                        }
                                                                                                                            }
                                                                                                                        }
