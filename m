Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C15B35FF44
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472407; cv=none; b=bkzGja4kHYeauNx/0p5t9ndB59Tfu+w+TMTk7u5eIgWc8UzC+wWvTC+zm77LaEdslHks3wdHip9ruDVoWJ/RlqxegdpZpXZyV2G7NwHWuVO36FfA8GYMdqon2LS1go5NCnMrnWm9k67XSf4FYjTGR6tPfnQ50IJAXXAmnlZzGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472407; c=relaxed/simple;
	bh=mwoYamMX+C4LOG3qk2bHenfle0rpDp5AHcC+7a69BvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5gTMo30B/qOJ3mIcMH2RHYl/ymQh15wTwabFEPQkrni/vEe4hLamoB7qDVeUY4odCKlLdI3utnm5UR5dt8WCHCJP/m2IJocK+Jelcw7SEKXdXZMqQ+/+TbG8fVnqNzvH32VK+YBxpOXDlm8CnhvtHYVbMMzs9AKqxuslyhFOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=POOTpyf2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="POOTpyf2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb2314f52so347529f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472404; x=1769077204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=POOTpyf2E8LQhfgcWoVnmGcwTv9cjx7t9nOoTBipWSoduSQDl2DtDEX5jXOGnGpHug
         /vEr3bRycNEF9KDphpixHf8pjEFI6ZYVF8QXfo2/p/K4igsaUNuTuTAXBRonG0hkEw3y
         zjPwl0nXJwH8C//iA7KkpuUuefoo6u/aeL1FN/9mZaiJHPN2asi8Bnj10GOb/8yZxglx
         Mo+8uDhw7wpooLcni7m/NfXXLd+GFxPn8auytjzx3hOMHRSxcVVJJnn1AEDU7nQEhSnb
         pM9pvUeivyUXXZdwnM+CoENtMt4wf2UWt/Iei7G0hU36UOd88kWLwxHkhYgi5FI9j7DC
         cpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472404; x=1769077204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=Ms64UmoC1x7XMHQEfq7UvTsRKkD0owbkvzpmNgfJx2psytYbNfpPopSwrbzOTUEGJ7
         UwgGUv4Wm/O9dDaIRvbdHmKj+XvvfJSWqpl6owpRJFFqxj+bdgWxIicCkbNGrntDH6DY
         CBn5N0Jx124Z3WaGLiR0aSpz6Lkr4x5b1qGQHyRLZCd9wez2iLyQ/oqvnlzssQIKBJo9
         0uIFkX/ZxtsyWt7FYAWQtrt1tqUv/MFhb4l/yIYuvRNXbUXKx4FpGwqGWgjDfPjSN1WX
         1pKOdQetUhUSvA5Vxg/JKgKhbDxy2c5muNYNgGKvS/o7/F8QB8NrzVMbOv988X3Udcma
         4AIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhUVrTlIHVucEa//UPQzdQAtLegS3Qt/KIslYtyPgGcete0LXtXq5Wh+bxK6dPJwqA0m3Uu9x9BBRd2qyezm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZbyQNqDbzizNBW0KWNyCTsI4xzhX+pWuAr68Objrf1sh1D6f
	vKnkhZLc7FfG1ybKLoYfG0gJ53YcBUH6/gkEGMEkBsk+ytNr05HhaxVbsKvWcykarlM=
X-Gm-Gg: AY/fxX7Vp/nc1JBYX45JksixbiKSR/d853Chcepo1AaQPWlHBeq9ZjpfsPlzXXnCtpc
	7T2f6q0nnBYZF95xmSsqvMu3252NnUOn8kGbEUsvfftvBjE1yrbBqPw9Yquh5678rkSfxh3brsV
	WfhVNmP7nT4F+vQS3iDyu8yY2x+0depH6gQfi5UbHYv/RL+OivwjTQ94MHwck6YBEUY4v75VR4E
	OGReTerEC/jO+jKluTdxeBPD4OpcyY0yDW52HMhzzH7Yv2jwJfadaVjJg0h3NFeh/eiLBdp3wjY
	jM70w5F1aKbl/aZ2GszfZKm1Tj5K4vYzIpOqyudSyWSqKrehY8no3AmcRUqMF017DyOFWOftVWf
	aLc/AhV66puOzxUKdbDncdve7z1MG3cn1bV65P4RUKIeILBAiDSw6kG300xDkSpysR+ML6EnIPM
	WxUWjSXyzbQCeXrg==
X-Received: by 2002:a5d:6b41:0:b0:432:a9db:f99d with SMTP id ffacd0b85a97d-4342c535db3mr5505744f8f.36.1768472403629;
        Thu, 15 Jan 2026 02:20:03 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653632sm5139931f8f.11.2026.01.15.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:20:02 -0800 (PST)
Date: Thu, 15 Jan 2026 11:20:00 +0100
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
Subject: Re: [PATCH 08/19] debug: debug_core: Migrate to
 register_console_force helper
Message-ID: <aWi_UJcrphO9Esxw@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:15, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
