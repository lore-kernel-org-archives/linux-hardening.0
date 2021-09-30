Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D383C4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889B561A0D
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350389AbhI3SWU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351123AbhI3SWU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:22:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB4AC06176D
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:20:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23so4819749pji.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rRzmSQnYKN75Gg93YuIv+rBGX5i47OpZAXZvIJOPAT0=;
        b=lEQ8DLBf3vFDxlv1guB97pybHM/E5OgqqY7s5GW48JHxOcQmMFcVANRfaTHTtWIF9Y
         9kRwW6x+vjlSmmTqC0Stb7CrJ/tg3DjlMrf5MAtA7cjscqC+AIUITJ17K3S1fLhd9/Xb
         H6Q003Tl/g15SHWxlAxw0KfC0GrYBfK6GsZ94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rRzmSQnYKN75Gg93YuIv+rBGX5i47OpZAXZvIJOPAT0=;
        b=UKHuW09yq8SzZHRa5cfgQcW2FF4agS1g3RWUcEcfs44EK5oluwrJVV/ef63waZd2en
         3pdH5qIHSxjcmGSdwMFvmOQawlCGsVxuvsDcgVKlbx2UbFyppDRC7Mv4u7s8KroKEZVq
         QJUglBE5A18NECzCIkaCKCjMeIDFm+70tz+ZGJUE6etF5O++QHy2TOrEqVu450epdHMT
         aadrGWoo6Ti7CLQpUzNHFu6OMIULkmfAHqVhARGGM/R1Q1JLUKm7SejR4KGkSPSFUqNC
         LC6V4FvRYuj5INA1ugu8zWjByQmmDHsBd8t15AZO4GZpAm45swj/agyfoUKoBuZsuJD3
         NB2w==
X-Gm-Message-State: AOAM533bjIRgHPwrtAmUdFsU94P4yJue0WCHffVgBZg0zhVLkHGMfQqU
        LA0YWSaY3Q5TrIYF+NmcTlstaA==
X-Google-Smtp-Source: ABdhPJyimYmtoacGEdurWEUSpaz+kvhw5xhIwlnWJodE7rV8ATefMii0ooqe8fOMpyVb9+6sAe5Wrw==
X-Received: by 2002:a17:903:2c2:b029:101:9c88:d928 with SMTP id s2-20020a17090302c2b02901019c88d928mr5409323plk.62.1633026036390;
        Thu, 30 Sep 2021 11:20:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10sm3720957pff.119.2021.09.30.11.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:20:35 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:20:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
Message-ID: <202109301120.B7B8F3F8A@keescook>
References: <20210929185823.499268-1-alex.popov@linux.com>
 <323d0784-249d-7fef-6c60-e8426d35b083@intel.com>
 <202109291229.C64A1D9D@keescook>
 <cf6ada34-9854-b7ad-f671-52186da5abd0@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6ada34-9854-b7ad-f671-52186da5abd0@linux.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 04:55:37PM +0300, Alexander Popov wrote:
> The kernel can hit warning and omit calling __warn() that prints the message.
> But pkill_on_warn action should be taken each time.
> 
> As I can understand now, include/asm-generic/bug.h defines three warning
> implementations:
>  1. CONFIG_BUG=y and the arch provides __WARN_FLAGS. In that case pkill_on_warn
> should be checked in report_bug() that you mention.
>  2. CONFIG_BUG=y and the arch doesn't have __WARN_FLAGS. In that case
> pkill_on_warn should be checked in warn_slowpath_fmt().
>  3. CONFIG_BUG is not set. In that case pkill_on_warn should not be considered.
> 
> Please, correct me if needed.

That looks correct to me, yes.

-- 
Kees Cook
