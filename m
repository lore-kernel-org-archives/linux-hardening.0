Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68933C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 04:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiLBE2g (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 23:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLBE2e (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 23:28:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B860B0B52
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 20:28:34 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w129so3839496pfb.5
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 20:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zy/Ex7u7vfXLg178nhAycFZbYuPh1ko3bHDnUc+ekUg=;
        b=DVZrKxj/YV9EslI7v2tLHsR1FiEwXMNUxQ9gWCulPvXvdarGELc/gu4ptL/Pb4w8q7
         PUR+L10dO3eiMmivzoF8IY9j93fV3fHoqCOhAHgHWnAjXyo+wLUSGKFoXWtWeZ8BHZ1b
         pcHzmKc1ZXfi/9JdUa6jHJ+PDcghndVkdipfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zy/Ex7u7vfXLg178nhAycFZbYuPh1ko3bHDnUc+ekUg=;
        b=GwTCNIo1uKxROJCQjeJ9Y0NSE58lwllEb3GfofiV/VuojH7bsAEifi9ioqh5+IX7MH
         u7kzztpnqqcrSjCqNSdjl55TCs4sljZesnn2ekisg48TR7Rwk2RWdriG+fO0NwLpm3Jf
         O7cPTm1PxAE4BJ5kyDGvkkmsSg6qoYCy04TUSWVCdUjtoSjJZqiOF21zZ83YBa+/mvmi
         TKkoQtDiPlRRoyr1CittaMmBH6ySaPIKiqeom281ANXQATJnrxBTZQX1G45ct0Qu8Ol8
         1IQu7Z3eQWVDfAhO/Z9o9ve2YUroD3U7dtzRWpY9FD/p6UUP945aCK2oR8LODi1TosUg
         r4eQ==
X-Gm-Message-State: ANoB5pk/Ec7USmF3fRjhc0BMOb1vYB2FIUbnVkQge0yDQ+ljQIMPggWM
        q484v/c1xRWoP9Hv2yCiW/2dCA==
X-Google-Smtp-Source: AA0mqf6QxVe/CuiF1SrrwDAO8NYTsmVIaix3PmH29JRc2+X6qOGRJqmO5wg3u5k4nvw5hMzmSczYNg==
X-Received: by 2002:a63:dc04:0:b0:46f:1262:8df7 with SMTP id s4-20020a63dc04000000b0046f12628df7mr54216081pgg.39.1669955313507;
        Thu, 01 Dec 2022 20:28:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00189847cd4acsm4536735pla.237.2022.12.01.20.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 20:28:33 -0800 (PST)
Date:   Thu, 1 Dec 2022 20:28:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, Petr Skocik <pskocik@gmail.com>,
        linux-hardening@vger.kernel.org
Subject: mocking init_task ?
Message-ID: <202212012008.D6F6109@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

I want to make a unit test for kill_something_info(), as there is a patch
to fix a bug with it not working as expected under a specific process
tree arrangement[1]. This seems like a great candidate for a unit test:
given a specific state, return a specific result. Emboldened, I applied
the "kunit: Support redirecting function calls" series[2], preparing to
mock group_send_sig_info(), and ran head-long into for_each_process()
... which uses the address of the global init_task:

#define for_each_process(p) \
        for (p = &init_task ; (p = next_task(p)) != &init_task ; )

:(

I'm curious what you think might be the right approach to mock
init_task, or for_each_process(), so I can apply unit tests to some of
the "simple" process tree walkers...

One idea I had was using the "kunit: Provide a static key to check if
KUnit is actively running tests" series[3], and do something like this:

#ifndef CONFIG_KUNIT
#define init_task_ptr	&init_task
#else
#define init_task_ptr	({					\
		struct task_struct *task = &init_task;		\
		if (static_branch_unlikely(&kunit_running)) {	\
			struct kunit *test;			\
			test = current->kunit_test;		\
			if (test->mock_init_task)		\
				task = test->mock_init_task;	\
		}						\
		task;						\
	})
#endif

#define for_each_process(p) \
        for (p = init_task_ptr ; (p = next_task(p)) != init_task_ptr ; )

And then tests can hang a mock init_task off the test? It seems really
horrible, but there is a LOT of global state in the kernel, so I figured
I had to start somewhere? :P

Thoughts?

-Kees

[1] https://lore.kernel.org/lkml/20221122161240.137570-1-pskocik@gmail.com/
[2] https://lore.kernel.org/lkml/20220910212804.670622-1-davidgow@google.com/
[3] https://lore.kernel.org/lkml/20221125084306.1063074-1-davidgow@google.com/

-- 
Kees Cook
