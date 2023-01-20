Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC72AC678D4
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Jan 2023 00:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjATA2r (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Jan 2023 19:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjATA2p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Jan 2023 19:28:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B410A25BD
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jan 2023 16:28:44 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d8so4095983pjc.3
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jan 2023 16:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZAy1Y8poHiv3/DrHCdfFCmw0t4/q9CU42X5LVblr5A=;
        b=bo7wkN/IPdQVxvTGSFxjsBBqC/EpA4zIw+0kKaMdUq1Ceeo+mcn0OwrlusF6IDbtPY
         COeHO7uC0iC/l7TK0uwB3XM0HL9dApX34LiilqOFMRqWQTUkOEeg08x5yyYb8yiLK89O
         SFCMFJJsIpf9NwlZlW+MGLC7boEsAGDj56+EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZAy1Y8poHiv3/DrHCdfFCmw0t4/q9CU42X5LVblr5A=;
        b=dS17kedQVjePAF5AVQvsZflOGItStK3zRLOfQ9pcX3CB9t6reYhgzxB+t/2zdp712Q
         NvaPTDUQKCeTfTufEMka1r84d0feXcpD5ZQu5wQ/4fP12M3jYjKs9ei7SftjQa/bPmtZ
         yhvPkcP503TT258MRgubH7tI4fdfRVno4D+fctWbNOBDfNCNJpS95ofrJRfekuiB8KJU
         u2rMKmsVuYWltob8aKKcpdUKCgtnjg23+ZY9+x3PeF+MCqQVUMbuRVqUqGSdXqHUcm49
         qdj8fYloEWLe9Ci8FM7rff/ZMOhrs6R1xQ3iWy+2uPPOirnSAXpDxTq2jSyDYr6I6cMP
         QCCA==
X-Gm-Message-State: AFqh2koiEN7lcbsbRNusaTzN3dc35xHDLFrSjMQrMKIpMM9If1jn2dL6
        E9tTAP5XlCn8OYGtaaF2vd8Lpg==
X-Google-Smtp-Source: AMrXdXtdx4/yGbslglkhzJkvG1BfbwF5m1Z+ARJ2282gHalN/ZaLh5DyiNEQo2fUbuB+AyrY4JALCw==
X-Received: by 2002:a17:903:11c7:b0:194:58c7:ab79 with SMTP id q7-20020a17090311c700b0019458c7ab79mr16848873plh.63.1674174523771;
        Thu, 19 Jan 2023 16:28:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902d58f00b001947c22185bsm11085080plh.184.2023.01.19.16.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:28:42 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:28:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Seth Jenkins <sethjenkins@google.com>
Cc:     SeongJae Park <sj@kernel.org>, Jann Horn <jannh@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/6] exit: Put an upper limit on how often we can oops
Message-ID: <202301191627.FC1E24ED5@keescook>
References: <20221117234328.594699-2-keescook@chromium.org>
 <20230119201023.4003-1-sj@kernel.org>
 <CALxfFW76Ey=QNu--Vp59u2wukr6dzvOE25PkOHVw0b13YoCSiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALxfFW76Ey=QNu--Vp59u2wukr6dzvOE25PkOHVw0b13YoCSiA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 19, 2023 at 03:19:21PM -0500, Seth Jenkins wrote:
> > Do you have a plan to backport this into upstream LTS kernels?
> 
> As I understand, the answer is "hopefully yes" with the big
> presumption that all stakeholders are on board for the change. There
> is *definitely* a plan to *submit* backports to the stable trees, but
> ofc it will require some approvals.

I've asked for at least v6.1.x (it's a clean cherry-pick). Earlier
kernels will need some non-trivial backporting. Is there anyone that
would be interested in stepping up to do that?

https://lore.kernel.org/lkml/202301191532.AEEC765@keescook

-Kees

-- 
Kees Cook
