Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258DBC433F5
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F8261439
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 18:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhJBSX4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:23:56 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35624 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhJBSXz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 2 Oct 2021 14:23:55 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWjMo-009FYI-Tn; Sat, 02 Oct 2021 18:04:11 +0000
Date:   Sat, 2 Oct 2021 18:04:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
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
        Thomas Garnier <thgarnie@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
Message-ID: <YVifGtn3LctrWOwg@zeniv-ca.linux.org.uk>
References: <20210929185823.499268-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929185823.499268-1-alex.popov@linux.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 29, 2021 at 09:58:23PM +0300, Alexander Popov wrote:

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -53,6 +53,7 @@ static int pause_on_oops_flag;
>  static DEFINE_SPINLOCK(pause_on_oops_lock);
>  bool crash_kexec_post_notifiers;
>  int panic_on_warn __read_mostly;
> +int pkill_on_warn __read_mostly;
>  unsigned long panic_on_taint;
>  bool panic_on_taint_nousertaint = false;
>  
> @@ -610,6 +611,9 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  
>  	print_oops_end_marker();
>  
> +	if (pkill_on_warn && system_state >= SYSTEM_RUNNING)
> +		do_group_exit(SIGKILL);
> +

Wait a sec...  do_group_exit() is very much not locking-neutral.
Aren't you introducing a bunch of potential deadlocks by adding
that?
