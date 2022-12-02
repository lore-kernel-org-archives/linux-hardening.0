Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A990C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 06:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiLBGxD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 01:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiLBGxC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 01:53:02 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891B970DC6
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 22:53:00 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id l67so4991691ybl.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 22:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KuNoZxiTrmfjKsxDRYPGbSZH4dvdETO0z/V8f41EKUo=;
        b=nVQJ9sDIFfHsNSTcfxNX0I66r0S9gWTXEsGYnQe7B6JZUSHz/aiElX7okc5+TsEA/N
         9W+Oxya7p3kXmaxF0501jvEKDY+yc5bzOqJQZfCQc2SjxOPKZsCpDXOKOm3PYX6vkYyB
         COHn0nIhQ69AeK/z1OutltGPUU+ZUADpgptSjDDwvGBfbf+RayUuGK8jWkaC82lJ+NvU
         hriwRTScshESej1++sQw0YGsB4Mt3/cnpVpgzOr4pDcm6F6y5K2NGjeedKN/1YarrF3v
         Y5nU0Y/4+nOivBuzAarWQjJJ72D8jpKJElGHVeBcR4QSnRJUCy1F9U6NPwTrF4s124Pu
         a1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuNoZxiTrmfjKsxDRYPGbSZH4dvdETO0z/V8f41EKUo=;
        b=tKaoctOS6wQKKmPd6lxLVtqa1+7cm1KAeIC1dwnh8J6mGQ0oEUJS/pBBFT99fY8CF+
         UDRvkp/cZ3h84V3nxMZCqTEzsQUuLADvEkDj0wG/QP2DzrZXQVuDNGmjzizagpk2udhh
         mx2r9wv7ZvwURVwfLLUK8n41O8Co8mLkDJ6jyRykWygRGP/6wZlFc+YFd5Di6ux4PZl3
         GVt+Qq//mkGXX+TCEGgz40qmzp1Nz29QEOxeLwo7hok8O3yvEkTTQ6PeAMX9hnJzFU2n
         WBBIkRm9C/Fr9U8y1a+XZzDbvnXUvLbSKuxjJJLdfnVLdKifT1cTPyGDFPcrrXQyk45q
         jYPg==
X-Gm-Message-State: ANoB5pmS/TUagrf0x2yWKtNo01B2nVmK070mtxmU/WZVdwz5DwVZMARc
        iqSERcrcUCOvkzxsaSy2uPO2tLJ5j1wugodm81+gmQ==
X-Google-Smtp-Source: AA0mqf4xZpa7c9YCUNgBdAUXTrufz1OtkArYdI4YWAEn3Nx7if9jEVF3Lw02VOThX2Ktr0XFRy1+4V2uqbHO4tTHJDk=
X-Received: by 2002:a25:aae1:0:b0:6e7:39fa:a7be with SMTP id
 t88-20020a25aae1000000b006e739faa7bemr48947108ybi.644.1669963979618; Thu, 01
 Dec 2022 22:52:59 -0800 (PST)
MIME-Version: 1.0
References: <202212012008.D6F6109@keescook>
In-Reply-To: <202212012008.D6F6109@keescook>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 1 Dec 2022 22:52:48 -0800
Message-ID: <CAGS_qxrf6zYkBaY29Z3QGw13vf7QK8SDgLpLC71a6FvwV5Sa6A@mail.gmail.com>
Subject: Re: mocking init_task ?
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, Petr Skocik <pskocik@gmail.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 1, 2022 at 8:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> I want to make a unit test for kill_something_info(), as there is a patch
> to fix a bug with it not working as expected under a specific process
> tree arrangement[1]. This seems like a great candidate for a unit test:
> given a specific state, return a specific result. Emboldened, I applied
> the "kunit: Support redirecting function calls" series[2], preparing to
> mock group_send_sig_info(), and ran head-long into for_each_process()
> ... which uses the address of the global init_task:
>
> #define for_each_process(p) \
>         for (p = &init_task ; (p = next_task(p)) != &init_task ; )
>
> :(
>
> I'm curious what you think might be the right approach to mock
> init_task, or for_each_process(), so I can apply unit tests to some of
> the "simple" process tree walkers...
>
> One idea I had was using the "kunit: Provide a static key to check if
> KUnit is actively running tests" series[3], and do something like this:
>
> #ifndef CONFIG_KUNIT
> #define init_task_ptr   &init_task
> #else
> #define init_task_ptr   ({                                      \
>                 struct task_struct *task = &init_task;          \
>                 if (static_branch_unlikely(&kunit_running)) {   \

nit: if(kunit_get_current_test()) is probably a bit safer.
For UML, it will never make a difference (IIUC), but we probably want
to ensure that current == the task_struct executing kunit tests.

>                         struct kunit *test;                     \
>                         test = current->kunit_test;             \
>                         if (test->mock_init_task)               \
>                                 task = test->mock_init_task;    \
>                 }                                               \
>                 task;                                           \
>         })
> #endif
>
> #define for_each_process(p) \
>         for (p = init_task_ptr ; (p = next_task(p)) != init_task_ptr ; )

I think this is pretty close to being the best you can do.

I have a terrible idea that afaict should work.
If it does work, I like it a lot better since it's less intrusive.

== my_test.c ==

#include <linux/sched/signal.h>
#undef for_each_process
#define for_each_process(p) \
        for (p = test_init_task ; (p = next_task(p)) != test_init_task ; )

struct task_struct _test_init_task = {
        .tasks          = LIST_HEAD_INIT(_test_init_task.tasks),
};

#define test_init_task ({ \
                        struct task_struct *task = &init_task;\
                        if (kunit_get_current_test()) {\
                                task = &_test_init_task;\
                        }\
                        task;\
})

#include <kunit/test.h>

static void my_test(struct kunit *test)
{
        struct task_struct *p;

        for_each_process(p)
                KUNIT_FAIL(test, "should not be called");

       /* can modify test_init_task as you see fit here */
}

And then you explicitly keep nothing else in this translation unit so
we limit the damage we've done.

Daniel

>
> And then tests can hang a mock init_task off the test? It seems really
> horrible, but there is a LOT of global state in the kernel, so I figured
> I had to start somewhere? :P
>
> Thoughts?
>
> -Kees
>
> [1] https://lore.kernel.org/lkml/20221122161240.137570-1-pskocik@gmail.com/
> [2] https://lore.kernel.org/lkml/20220910212804.670622-1-davidgow@google.com/
> [3] https://lore.kernel.org/lkml/20221125084306.1063074-1-davidgow@google.com/
>
> --
> Kees Cook
