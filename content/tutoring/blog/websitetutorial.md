---
title: "How to Build a Hugo Blog on GitHub Pages"
date: 2023-11-01T18:55:48-04:00
type: page
layout: blog
author: Sarah Helmbrecht
featured_image: "images/websitetutorial/websitebuilding.jpeg"
url: /blog/websitetutorial
draft: false
---

I built the first version of this website several months ago using Hugo and GitHub pages. I recently started from scratch so that I could change the theme and fix some mistakes that I made the first time around. In this article, I will share what I have learned.

There are countless different programs and websites that promise an easy, stress-free website-building experience. I can't say that this way is the easiest, but it allows you to build a completely free website that is much more customizable than the ready-made sites you can find through common website-building platforms. Most of the required coding is in Markdown, which is basic enough that I'd assume most people could pick it up quickly.

I've had difficulty finding a tutorial that truly encompasses everything that is required in order to build a Hugo website hosted on GitHub pages, so I decided to make a tutorial myself. I will share all of the steps that I took in order to build the website you're looking at right now.

### Create a Repository on GitHub

We need to create the GitHub repository that will host our website. Go to [GitHub](https://github.com/) and either create a free account or log into your existing account. On the left-hand sidebar of the main dashboard, click the green ''New'' button next to the words ''Top Repositories.''

You can only make one primary website associated with your GitHub account (i.e., [skhelmbrecht.github.io](https://skhelmbrecht.github.io)). All other websites you make will branch off of that website. If you wish to have your website URL be \[your_username\].github.io, then name the repository exactly that. If you name your repository something else, such as ''blog,'' then the URL of your website will be \[your_username\].github.io/blog. You don't need to mess with any of the settings quite yet; just create the repository.

### Get Started with Hugo

Next, we need to install Hugo. Go to the terminal on your computer. To install Hugo on Mac using Homebrew, you'll type in the following:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install hugo

For other systems, please consult [Hugo's installation  documentation.](https://gohugo.io/installation/)

With Hugo installed, we can now create our website! Enter the following into the console to create a new site and change your current directory to the new one:

    hugo new site [repository_name]
    cd [repository_name]

### Create Local Git Repository

On the GitHub website, go to your repository's homepage. There should be a list of console code under the words ''...or create a new repository on the command line.'' Type this code into the terminal. It should look like this:

    git init
    git add README.md
    git commit -m "First commit"
    git branch -M main
    git remote add origin https://github.com/\[your_username\]/\[repository_name\].git
    git push -u origin main

### Add a Hugo Theme

Now for the fun part! Choose a Hugo theme from [this list.](https://themes.gohugo.io/) I am using the Ananke theme. I highly recommend this one; it's sleek and has built-in features for comments and a contact form. Don't be tempted to choose a theme just based on looks. Make sure that the documentation is actually accessible to you, or you won't be able to use all the cool features that drew you in. Ananke's documentation is much more thorough than that of the theme I used previously.

The GitHub repository for your theme should have installation instructions on its homepage. For my theme, I entered the following into the terminal:

    git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke

After adding the theme, read through its GitHub repository's homepage for any theme-specific tips about how to edit the config.toml file to your liking. Here's what mine looks like:

    baseURL = 'http://skhelmbrecht.github.io/'
    languageCode = 'en-us'
    title = 'Sarah Helmbrecht'
    theme = 'ananke'

    SectionPagesMenu = 'main'
    Paginate = 3
    googleAnalytics = ''
    enableRobotsTXT = true
    disqusShortname = "[my_disqus_shortname]"

    [sitemap]
      changefreq = "monthly"
      priority = 0.5
      filename = "sitemap.xml"

    [params]
      text_color = "black"
      author = "Sarah Helmbrecht"
      description = "An academic portfolio and blog."
      background_color_class = "bg-black"
      recent_posts_number = 3
      read_more_copy = "Read More"

### Create Appropriate Directory Structure

The appearance of your Hugo site will be highly dependent on the directory structure that you use. Each subfolder and markdown file within the ''content'' folder represents a tab on your website's navigation bar, unless its name begins with an underscore. My content folder contains an ''_index.md'' file that determines the appearance of my site's homepage:

    ---
    title: "Sarah Helmbrecht"

    description: "Math M.S. @ NYU Courant"
    theme_version: '2.8.2'
    cascade:
      featured_image: '/images/Banner_Image.jpg'
    ---
    Welcome to my academic portfolio.

I would also recommend that any subfolders of the content folder contain their own ''index.md'' file. For example, my ''content/blog'' folder contains an ''index.md'' file with the following content:

    ---
    title: "Blog"
    date: 2023-03-02T12:00:00-05:00
    url: /blog
    ---

This ensures that the name ''Blog'' appears correctly on the website's navigation bar, and that the URL appears the way that I want it to.

Images that are used within your content should be placed in the ''static/images'' folder. You can reference them within your content using only ''images/'' as a prefix.

To see how I set up my directory structure, feel free to check out how I set up my own website's [GitHub repository.](https://github.com/skhelmbrecht/skhelmbrecht.github.io)

### Create your First Post

If your goal was to create a blog, then it's time to start publishing content! In the command line, after cd-ing into your repository, enter the following in order to create your first post:

    hugo new blog/first-post.md

This will create a new file in ''content/blog'' called ''first-post.'' Open the file in a code editor. You can change the title and date in the header of the file. You also need to change ''draft'' to ''false'' in order to make the post visible on your site. You can also change the URL, and depending on your theme, you may be able to choose an image to be the banner of the webpage.

### View the Website Locally

Before you publicly publish your website, each time you edit it, you should make sure it looks good on your local server. To do this, type the following into the terminal:

    hugo server

This will allow you to see what the website currently looks like before posting.

### Posting the Website to GitHub

First, go to your GitHub repository's settings. Click ''Pages'' in the left-hand navigation bar. Under ''Build and Deployment,'' change the source to ''GitHub Actions.'' This will generate a ''hugo.yml'' file that creates a workflow. Basically, this means that each time you push local changes to GitHub, the workflow will automatically run and publish your website publicly.

Now that you have the workflow set up, if you like how your website looks on the local server, it's time to publish it! If your website is something super important that a lot of people will see, don't push directly to main. But if, like me, you're a grad student who gets very little website traffic, then you can afford to be lazy. Here's what you'll enter into the terminal each time you want to publish the current version of your website:

    git add .
    git commit -m "Description of the changes I just made."
    git push origin main

Now your website is public!

### Connecting a Custom Domain Name

Building a website this way is free, but buying a custom domain name is not. I decided to go ahead and buy the domain [sarahhelmbrecht.com](sarahhelmbrecht.com) on GoDaddy. I generally followed the instructions [here](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site) for an apex domain, but ran into a few hiccups- mostly related to my own impatience. I learned that you can't just buy a domain name and immediately have it configured properly. If you're going to get a custom domain, I recommend that you do it early. There's a chance your whole site could be down for a day while you wait for the configurations to update.

To connect this custom domain name to my website, I first went to the settings of my GitHub repository and clicked on the ''Pages'' tab. Under ''Custom domain,'' I typed in [sarahhelmbrecht.com](sarahhelmbrecht.com). The DNS check initially threw an error, but it worked eventually. Next, I went into the DNS configuration on GoDaddy. I added a type ''A'' configuration called ''@'' with the values 185.199.108.153, 185.199.109.153, 185.199.110.153, and 185.199.111.153. Several hours later, I put the following command into the terminal:

     dig sarahhelmbrecht.com

Sure enough, the ''A'' records were visible. Next, I put the following into the terminal:

    git pull

This command pulls the updates from GitHub into the local Git repository.

24 hours later, GitHub allowed me to enable HTTPS encryption. Without this, all visitors to your website will be warned that the site is not secure.

One of the benefits to using a custom domain name is that it makes it much easier to set up Google Search Console, a free service that makes your site show up in Google searches and helps you measure search traffic. It's integrated with GoDaddy, so setting it up was a breeze. I Googled ''site:sarahhelmbrecht.com'' and clicked the link that popped up, then typed in my website name again. Google did the rest for me. Finally, I just had to submit a sitemap so that Google would start indexing my website sooner.

### Conclusion

Creating a website using Hugo and hosting it on GitHub pages is a simpler task than it may seem. All you need is a working knowledge of Markdown and GitHub- although everything you should need to know about GitHub for this task is within this tutorial, and there are plenty of online resources for learning Markdown. My hope is that after reading this, you feel confident enough to make your first attempt at a free, highly customizable website. As you become more comfortable with Hugo, you can build increasingly complicated websites. Plus, you get to brag that you did it yourself.
