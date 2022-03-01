Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55257C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Mar 2022 06:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiCAGnr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiCAGnq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Mar 2022 01:43:46 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2E49248
        for <linux-hardening@vger.kernel.org>; Mon, 28 Feb 2022 22:43:04 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g20so20648948edw.6
        for <linux-hardening@vger.kernel.org>; Mon, 28 Feb 2022 22:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IqwMuZ8fxt+QmrdqHOlImG77CSzeOXAfU3F7s/g1es=;
        b=Zt7ADjjg4rQdQMZupIjoQnW8OZzkrW1QqynxdshmIEkct/PUWuc8mHmtaLMl7SRf4j
         O/SsyFxp+cXtdodgFZY1yMgZ2bgTQgu4U8POD6AExh1V8MJIq3bb7qef796sT4BUC6Vq
         2dGy0L5SzrT/5p9DN1SjVbc8UkJUnWYEDpsOv6Fszv3rzZ728aXUFTHimB0CAxkBX4DX
         xrufVPSLR9vwBy1h/CSAOqSR+pgCZyQ+7DUcXmZjFeG9I0KcBRC82y7KxWo00HF556jR
         M4UWSK1tWyrR/CgjgF6TF8QOCgtuVLdDxoUX7rPxIEp1+gTuWTERDx1fKUxHvoWeI9qA
         5XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IqwMuZ8fxt+QmrdqHOlImG77CSzeOXAfU3F7s/g1es=;
        b=j3Mz0PWn/hMh8GIiMemXex2WFXD86fAisxu4tTExlwq4elriGyLKPv7XmYJR5cZLVD
         Jf8aSH/4g/sAta8EM75Ox+DoaN5u1NjbCu0JyhjKqKr9+s3736JiEYY7rbWL1Htz3uj1
         xOJoZbVbPfTgtD9W/YzibQmmsWEShKHb8oyegq2Fdxm1vFSOVjg98TqSQImnpn3XCxKu
         AZC4PiuVULP0P43vITaPm5l8mNk9uspfiPGSOnNw34mrt3vcZYJNDXyM2QZkKgw79oY0
         q9EzbYTPl85a7n1ZuGKfHKE4AvT5T1QEEjqIyv1D0nVJ9gylaC5Xz1MofgZWcPZ9qF//
         WTUg==
X-Gm-Message-State: AOAM530oBblrbFjBQGnCULBsPfIYPdogm4zR6N2YfmgY2AfXBV+GnDlp
        ofIfnDR5iPsmhzb/qq0oBGK5wLpO6tT0KDm7NGQ1fw==
X-Google-Smtp-Source: ABdhPJzgEhCVEPSEh42pl5bgolf24c2VjNrVdrJH7yCpF+rJiuGUvKUvHAmfssDpqzWoeXIVZ0eqJZpsefLLCWPpQLc=
X-Received: by 2002:a05:6402:375:b0:404:c2be:3b8c with SMTP id
 s21-20020a056402037500b00404c2be3b8cmr22490537edw.247.1646116983110; Mon, 28
 Feb 2022 22:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20220224054332.1852813-1-keescook@chromium.org>
 <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
 <202202232208.B416701@keescook> <20220224091550.2b7e8784@gandalf.local.home>
 <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com> <20220228232131.4b9cee32@rorschach.local.home>
In-Reply-To: <20220228232131.4b9cee32@rorschach.local.home>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Feb 2022 22:42:51 -0800
Message-ID: <CAGS_qxprS1e_f_K6bi-RvVESoPJ2yQgQVszcmcRFq_VQWduyAA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWFnbnVzIEdyb8Of?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Feb 28, 2022 at 8:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 28 Feb 2022 17:48:27 -0800
> Daniel Latypov <dlatypov@google.com> wrote:
>
> > He also prototyped a more intrusive alternative to using ftrace and
> > kernel livepatch since they don't work on all arches, like UML.
>
> Perhaps instead of working on a intrusive alternative on archs that do
> not support live kernel patching, implement live kernel patching on
> those archs! ;-)
>
> It's probably the same amount of work. Well, really, you only need to
> implement the klp_arch_set_pc(fregs, new_function); part.

Yeah, that's the only bit we'd need to get working.
I called this out in "Open questions:" bit on
https://kunit-review.googlesource.com/c/linux/+/5109

As for the amount of work, I know how to do KUnit-y things, I have no
idea how to do livepatch things :)
Also, we're not aiming for something as "magic" as the ftrace one.

David's patch is here: https://kunit-review.googlesource.com/c/linux/+/5129
Here's a snippet from the example in that one:

static int add_one(int i)
{
/* This will trigger the stub if active. */
KUNIT_TRIGGER_STATIC_STUB(add_one, i);

return i + 1;
}

i.e. users just add this one macro in with <func> and <args>.
It internally expands to roughly

  if (<check if current test has registered a replacement>)
      <invoke replacement with <args>

So it's all quite simple.

But it'd definitely be interesting to try and get klp_arch_set_pc()
working on UML if that's a possibility!
Speaking from ignorance, I can see this either being somewhat simple
or very painful.

>
> -- Steve
