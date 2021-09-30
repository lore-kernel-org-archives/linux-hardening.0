Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4645C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CBAE619EC
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 13:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbhI3N52 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:57:28 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38496 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351510AbhI3N50 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 09:57:26 -0400
Received: by mail-wr1-f54.google.com with SMTP id u18so10233884wrg.5;
        Thu, 30 Sep 2021 06:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XIBvChFKd70IQU/OaMjJCINVW+wyQl1HNkbZBhbOPoI=;
        b=8CfbARVXFzf7MFBoctitWkTl1kPbsxP1NaDzyzQr5w/U/szRkMB+SjHzCmbA88cYJ4
         xVMkeqnD5WO6QxYteYELVw2N1cDACd41B10puoNWA6xSmJmEBSJFCPj+6bfJGYgznwAU
         e+tOrNlcFMp06UUyfXEe33QdPp2uR973I/HrqxQMGcjj0eSFvF8/obmvdhSRw8btTfo/
         3bEBxxy0fEht85a6jf4Qw7QTSYO+81fTgJ237g7UTd9Gy6qbNsKEx5ghwmXJhmVuDJtk
         +jb11NmXy7rZuhn/JfEYNuoKRejfmeB36ULLi9R7crt4a9GB3/ctb9YV37IIJfTZeO8K
         hkrg==
X-Gm-Message-State: AOAM533OR057nFfXUzhOu4BvayMpnIa2KpEFNDSrptaqB/ebL8o/1njj
        8GMrrMqZIUnBYx9NuGBeM80=
X-Google-Smtp-Source: ABdhPJyfiFxiOHTqszHIrDDHSj7cKIx9P6KR71PRpxnSn6DAWepMhnjvSct+GsB9xt+w+bIBcMmn/w==
X-Received: by 2002:a5d:64a3:: with SMTP id m3mr6461208wrp.157.1633010142527;
        Thu, 30 Sep 2021 06:55:42 -0700 (PDT)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id i92sm3028618wri.28.2021.09.30.06.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 06:55:42 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
To:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
References: <20210929185823.499268-1-alex.popov@linux.com>
 <323d0784-249d-7fef-6c60-e8426d35b083@intel.com>
 <202109291229.C64A1D9D@keescook>
From:   Alexander Popov <alex.popov@linux.com>
Message-ID: <cf6ada34-9854-b7ad-f671-52186da5abd0@linux.com>
Date:   Thu, 30 Sep 2021 16:55:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202109291229.C64A1D9D@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 29.09.2021 23:06, Kees Cook wrote:
> On Wed, Sep 29, 2021 at 12:03:36PM -0700, Dave Hansen wrote:
>> On 9/29/21 11:58 AM, Alexander Popov wrote:
>>> --- a/kernel/panic.c
>>> +++ b/kernel/panic.c
>>> @@ -53,6 +53,7 @@ static int pause_on_oops_flag;
>>>  static DEFINE_SPINLOCK(pause_on_oops_lock);
>>>  bool crash_kexec_post_notifiers;
>>>  int panic_on_warn __read_mostly;
>>> +int pkill_on_warn __read_mostly;
> 
> I like this idea. I can't tell if Linus would tolerate it, though. But I
> really have wanted a middle ground like BUG(). Having only WARN() and
> panic() is not very friendly. :(

Ok, let's see.

Kees, could you also share your thoughts on the good questions by Petr Mladek in
this thread?

>>>  unsigned long panic_on_taint;
>>>  bool panic_on_taint_nousertaint = false;
>>>  
>>> @@ -610,6 +611,9 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>>>  
>>>  	print_oops_end_marker();
>>>  
>>> +	if (pkill_on_warn && system_state >= SYSTEM_RUNNING)
>>> +		do_group_exit(SIGKILL);
>>> +
>>>  	/* Just a warning, don't kill lockdep. */
>>>  	add_taint(taint, LOCKDEP_STILL_OK);
>>>  }
>>
>> Doesn't this tie into the warning *printing* code?  That's better than
>> nothing, for sure.  But, if we're doing this for hardening, I think we
>> would want to kill anyone provoking a warning, not just the first one
>> that triggered *printing* the warning.
> 
> Right, this needs to be moved into the callers of __warn() (i.e.
> report_bug(), and warn_slowpath_fmt()), likely with some small
> refactoring in report_bug().

Yes, I see now. Thanks, Dave, Peter and Kees.
The kernel can hit warning and omit calling __warn() that prints the message.
But pkill_on_warn action should be taken each time.

As I can understand now, include/asm-generic/bug.h defines three warning
implementations:
 1. CONFIG_BUG=y and the arch provides __WARN_FLAGS. In that case pkill_on_warn
should be checked in report_bug() that you mention.
 2. CONFIG_BUG=y and the arch doesn't have __WARN_FLAGS. In that case
pkill_on_warn should be checked in warn_slowpath_fmt().
 3. CONFIG_BUG is not set. In that case pkill_on_warn should not be considered.

Please, correct me if needed.

Best regards,
Alexander
