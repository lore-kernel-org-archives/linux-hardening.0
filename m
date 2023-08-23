Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878CEC7113B
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Aug 2023 21:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbjHWVJR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbjHWVJL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Aug 2023 17:09:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2810D8
        for <linux-hardening@vger.kernel.org>; Wed, 23 Aug 2023 14:09:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68bbd45d0d5so285561b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Aug 2023 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1692824948; x=1693429748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JFA7r4cNhfzTJhPZhI+QcYB/p/GZPr14BEMJCD/PtOY=;
        b=DVckDtCpUXRZBc77gErGk4Njjl0I5ExAOMx3zbSBKDzFTqbAzgH1O82f1FsJbF+NXF
         8DfAkedAkVgGvDB5ZFEg7wOprm0ebkbeK62SVA7zX6yzjBwJ4oAz+LhLzRpHXqpzCo6m
         Yg/5bwuDAlASbTneg6yNCmtH1R+GDwLfQK1/JP4V6AggmATXovZC0q4zy2g+yjAiA5E6
         +jovmx6t+9fkOuQxLMncFc5PF5msuM642r17sCwPOqlVZPjbPkVsugGNJfIsJRFHOXME
         OA6Pk6PbRPtPeBOanECX43/fk7bvhkglQ9HtLaXWqG1DUa6sRGb6wv59WvfLxsz0xDNQ
         rcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692824948; x=1693429748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFA7r4cNhfzTJhPZhI+QcYB/p/GZPr14BEMJCD/PtOY=;
        b=NLtQrsUrJkUt5Ku8mgxv5rU1pbRjf290ZCW+eDGl6RqBp8vSv+XADScyT1FP9Cuxct
         uZwZNKjsE6APtL+ogUR1gEAnzKbZ99X5m7g3LgFeGg8F3x8hz4JZXN+7X+WHkqyAZQXe
         rGA3ADtfrSgNZ1+RlhgPtp0oUtY1O2VAIsw7loKnMivyK4UiLdYswybsD0FtK5ixD24r
         sT99bwd814Klg5dRKucqO3adMXYQrYSKPrmnKhlTYJpPjnt9IWs7GdiiYPaiAIQFP8mc
         9bHJ79kYTmM9Qz1TmR+D/hr9UY+OMAEq965lGOdU/ZWH/PZ/hiFOg/ZGFauCXq9qsF34
         Juvw==
X-Gm-Message-State: AOJu0YzcMW2+lLdcSRNFJ1lXewuZjTCXkYu5sRoJ9RxLKdYAbjh9nlXj
        VXvJ2vHxzgRbRvwDbmJ0VBLqpQ==
X-Google-Smtp-Source: AGHT+IFMSv5r5leBe1LvmuzI1T7xBfHmYz/q0tLbnGP7JZsx/vAE7FzTymHX6XV8fUlxXrab4Cef6g==
X-Received: by 2002:a05:6a20:7da6:b0:12e:f6e6:882b with SMTP id v38-20020a056a207da600b0012ef6e6882bmr17494947pzj.1.1692824948655;
        Wed, 23 Aug 2023 14:09:08 -0700 (PDT)
Received: from cork (c-73-158-249-15.hsd1.ca.comcast.net. [73.158.249.15])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78c0a000000b006875df4773fsm1927889pfd.163.2023.08.23.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:09:08 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:09:06 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Uday Shankar <ushankar@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Len Brown <len.brown@intel.com>,
        linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] Revert "ACPI, APEI, use raw spinlock in ERST"
Message-ID: <ZOZ1cmqF3G0XO0ZH@cork>
References: <20230822010933.2247671-1-ushankar@purestorage.com>
 <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOQodU1CNMRtjYZ6@cork>
 <20230822234522.GA2590891@dev-ushankar.dev.purestorage.com>
 <87cyzebi00.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOV1sM8xZ6+P48Z1@cork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOV1sM8xZ6+P48Z1@cork>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 22, 2023 at 07:57:52PM -0700, Jörn Engel wrote:
> 
> You are right.  I'm actually quite surprised how we turn a trylock into
> a spinning lock.  Now I know, thank you!

On that subject, why do we turn a trylock into a spinning lock?  Thomas,
is there a good argument against a patch like the one below?

If the question was ever considered, it seems to have happened outside
of mainline.  At least I cannot find it in git history.

Jörn

--
If you cannot make a function run 100x faster, maybe you can
call it 100x less often.
-- Unknown

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index fcd9ad3f7f2e..5bda84d5879a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1255,11 +1255,13 @@ static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
 
 	/*
 	 * The mutex has currently no owner. Lock the wait lock and try to
 	 * acquire the lock. We use irqsave here to support early boot calls.
 	 */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	ret = raw_spin_trylock_irqsave(&lock->wait_lock, flags);
+	if (!ret)
+		return 0;
 
 	ret = __rt_mutex_slowtrylock(lock);
 
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
