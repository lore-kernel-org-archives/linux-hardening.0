Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468339A801
	for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396346; cv=none; b=edf/2EGtRgqGcacNaQbu4Sp3BEeEDWQXaN5NB+8anbG3DXdGzZTVPOEenB7afHFYeKeqXhlBfj2nHzCYw0Bbf9P6R7jTB7F1Cpm0Yr6hkgM3GO3Ppq6aETgDe7HOBSut3N1CuBACE5kv6pPMYJuFNZKTCTNioZXysE8CXN8Y98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396346; c=relaxed/simple;
	bh=qVQVDrDK8GQt0EFjDkN2BeDB9NxS3hqaAC/BXhJUBXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDvtgNbCk1aqgyy6TtRqx0/ZqM+9lRAS6dANC/PK1+t9eFvvOQWdT1BoSZWb8n/BfiGp0CysOi8xcFzpLKq/Dwf7zrvHO9jO9wCgRtqIMAZho2NV1xIuI5/01Lze0TST1ohBEGeA+n6ENFXI8uOVPORfXQFyAYT6K6gdqr+9iQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L1iB/yNj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L1iB/yNj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47796a837c7so59384075e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768396343; x=1769001143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucpTGToIn8N6Wm60fm7MZ05SRRlKYptl+ek5X25PfwQ=;
        b=L1iB/yNjYqm3FvqWymV6AoNf5MtA+Y6/OWs/RJg3e7CYxfZqQFULHvSUfTEk4onLe3
         K8kZuPagmhqvDJFtw9c9UTxqcd+qJZkw4PQl4BUg5k4yF9scQKi9RHMwyVcofMOLNmf9
         pbhNXDMXDshXlT74Wh0bXiV5vvKeLUf6p39IJ8wY5dpK6KBsy4W3IFGstIqmYoUCnIw4
         nqRilxwC37pzPLIWVgJsrDbAi5fP08rSd1LIYgBshYGZ1PcyNhk5nl3IPlrRV45sac/Z
         Yxfv6Z4RUlHmbXdVWT3j7gI66pAgzx3k3AqR7HGarevdhb1crqPGqGHXY8Pe43pEFeZ4
         oD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396343; x=1769001143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucpTGToIn8N6Wm60fm7MZ05SRRlKYptl+ek5X25PfwQ=;
        b=wAKtqwOp3IayqcnXkrCQXg7nn+toGCvbPbkylr/vPn23+nbfiG/2hpi6NFnkaYbKpd
         0CdfW8dxv/ePpnfZrRVtfDEXskN2tIFIcRtGUhYy6QRIJyapnrP/VAbgEdr6o/aqVOv0
         5udEhITx2lYYVIheay6dY3swi94rpS17BnYTM9ABSNep2/wkjk35OWXRuVAR7AkaTHMg
         r5HuFfyz0TQSvylbLu5umJFg7/CnU4kPaa9m9sP0Y89bIuSpXQFwCX7Lk9WkO4WfVFgl
         7C614ZY8+QHRIlJQomp/cIS9DPFqgDZvbaDX+2W2Yis/LzoG8OUrl19Fi1she1M04SOF
         2n9g==
X-Forwarded-Encrypted: i=1; AJvYcCXrfwax2bvGrWjLNLUROnkfoimJWPqE6g+vhZiVYX7oUi/F8aniSUzqQ+4NVCNOdCyECMihXiDSk9RtmKnIwDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ntzKq04rTOElm0rLJxWQ0EZxQEpxlwsye+tUkSN7W/G76+CU
	nA5IIPkdtpm0y2wxfMnY6OLxNIEn0iAUqZliegmc3eYz2PZKpWzbcDYWMCm0sD7EJWg=
X-Gm-Gg: AY/fxX7TGecrYXS9qJ+2Ztb3VBC0kRbzLKMwJm/mt7Gnf9mvWnnvhDTzMyPrWzE30XO
	0JJvdeeIyOg9aX++b1nCYw44evv5bbMB4hVGJSZNYzhhQkncszzJw4YHKNDK18wBfhA0D0xwCsE
	mQkc33burjPOM1M49T8GAEjd6Yhudat/RW6oc9jt1yPOmbvHiL9bC9idjRl8hB7Yd0gfk9u1XIc
	CUMEh2CkhxpGuxzuB9d9tycKwTqVJGl69Gw6PwJi9K18Cwn4fstAs3nUG+d1DKdF5DAED45EsGI
	rd29V1njMES2eVWxBc8yLf9G4jQ8wQOGVakz6haYo1GeK0ozI4Hg+8qdwi3tulO+FAz0Eh0bb0H
	jwjFOuOUArr5FbPY0JTiukRooBPklCx0taBfCjPrgIvMmJAkHpmsvvparufMEGXPDm5TL2bpD2F
	pbhWsQ9FOFZXXunbFEpCLn7LX4
X-Received: by 2002:a05:600c:5490:b0:479:3876:22a8 with SMTP id 5b1f17b1804b1-47ee3356d5dmr36820375e9.16.1768396341643;
        Wed, 14 Jan 2026 05:12:21 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b8c9bsm27274065e9.3.2026.01.14.05.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:12:21 -0800 (PST)
Date: Wed, 14 Jan 2026 14:12:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/19] printk: Reintroduce consoles_suspended global state
Message-ID: <aWeWMga1VaT0sYwj@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-4-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-4-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:11, Marcos Paulo de Souza wrote:
> This change partially reverts commit 9e70a5e109a4
> ("printk: Add per-console suspended state"). The intent of the original
> commit was to move the management of the console suspended state to the
> consoles themselves to be able to use SRCU instead of console lock.
> 
> But having a global state is still useful when checking if the global
> suspend was triggered by power management. This way, instead of setting
> the state of each individual console, the code would only set/read from the
> global state.
> 
> Along with this change, two more fixes are necessary: change
> console_{suspend,resume} to set/clear CON_SUSPEND instead of setting
> CON_ENABLED and change show_cons_active to call __console_is_usable to
> check console usefulness.

I would invert the logic a bit. I think that the main motivation
is to replace CON_ENABLE -> CON_SUSPEND.

<proposal>
The flag CON_ENABLE is cleared when serial drivers get suspended. This
"hack" has been added by the commit 33c0d1b0c3ebb6 ("[PATCH] Serial
driver stuff") back in v2.5.28.

Stop hijacking CON_ENABLE flag and use the CON_SUSPEND flag instead.

Still allow to distinguish when:

  - the backing device is being suspended, see console_suspend().

  - the power management wants to calm down all consoles using
    a big-hammer, see console_suspend_all().

And restore the global "consoles_suspended" flag which was removed
by the commit 9e70a5e109a4 ("printk: Add per-console suspended state").

The difference is that accesses to the new global flag are
synchronized the same way as to the CON_SUSPEND flag. It allows
to read it under console_srcu_read_lock().

Finally, use __console_is_usable() in show_cons_active(). It is the
last location where the CON_ENABLED flag was checked directly.

The patch should not change the existing behavior because all users check
the state of the console using console_is_usable().
</proposal>

> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e2d92cf70eb7..7d2bded75b75 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3552,9 +3552,9 @@ static ssize_t show_cons_active(struct device *dev,
>  	for_each_console(c) {
>  		if (!c->device)
>  			continue;
> -		if (!(c->flags & CON_NBCON) && !c->write)
> -			continue;
> -		if ((c->flags & CON_ENABLED) == 0)
> +		if (!__console_is_usable(c, c->flags,
> +					 consoles_suspended,
> +					 NBCON_USE_ANY))

It would be better to move this into a separate patch.

>  			continue;
>  		cs[i++] = c;
>  		if (i >= ARRAY_SIZE(cs))

Otherwise, it looks good.

Best Regards,
Petr
