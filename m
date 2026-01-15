Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4E396B7F
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479893; cv=none; b=NDoLqtjZIbzJ9asfKJCBl13cHX6y5OitY+gLLNUphxGEFAO8TdHVBFzMEpdmM4a8Wzd0ka6ZPSpFwth/DQ/LSI0GK90uBJUh4t/m/zDI2phduqsUhMn01Nb06DfPJYg4VqehE2pUI7pn6jA71lQp7si3V5Y59Pjr45syL7lIyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479893; c=relaxed/simple;
	bh=L1TTyH0HQfm7i7n+eqeYhrSGiuwmELmvtw7QQ3GNH2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyvxyRdyfOGQc/G5da1hW/Cp510AqJ6kBt05JJgXdpsxJ6f+NQAoUvthSHE/8hPuvGQzLhxLf+xa3Q6/Cuxew4JasSxYsFP9Jtx/DUaEjjlRMAG0ve8y0f72QufLBdgVDuhoAiG/TF87ITWqHKp40gwpYRkWLfJ4AwhfUldzYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AavSW8zD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AavSW8zD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-430f57cd471so530314f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479883; x=1769084683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=AavSW8zDa7wyUQOrKCsE5mEiLhCbCgtNLUJDLiygsCIz5MtcNfL5qg5hmiFSH/hnLF
         dY1NM5kxU9pSW9DgohxUfSzAVt+iLYuHkRY/WkdFE1XVmgvI8pljiAwerID8UL6g7PU/
         eolJwYFX6Yj0B7yZch1EvVk8qqbK6y7rtIhghbakTGjeNT0IeZm0hOjwyUU0ncWi7Ohd
         fORx/nYcwlXu0aeT6z2nysNJs2vxMwjVnQi03RkyIvPvmebQbr0uJa/GOMbQXodXURQ6
         +ZErOfCH6CKBneuJM1DXIQJeb7qxioDN+X5ZyEYo1486PL/QTstgRmV32S5n4c6fMV9G
         3dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479883; x=1769084683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=mY+DG5MWgK8ufGnOTEZXBbm8iifbJ5/p4LcgjbTsxt0UOLV431HZVcyxDCBGgERazh
         gGGj9K73O67O4uLi6KXaO/WCqHBl30YXip5Ljw0jzkDadUam/20pSscMVrhkzHUR9Yq0
         CX5PbpTgYwf7TWvmWdark9INu7CTVSY4eVlbRe/PX7Quj4PfmfnnJFQGGoHu2T82XZFY
         HE/GceHn+LJrNgpuuzpzfiKmNUzMBhHcDX9OCLS1D/eqLBBieRxT3wEwGo7hZSbzgqld
         jQle99OYTjB2O0qMhXvVJBxO5wwLOsweK/DxVvzLIFetw5bdOzK0xa2Ugu0oJifHj2ti
         CNaw==
X-Forwarded-Encrypted: i=1; AJvYcCWqEcaRc5CzDg+Ut8lLH9MgWD0tlndc90JUNRonYWjlKWW2PSwTttUHaHA8RDBzcfdTyD6MQ8nqb2QB72qYTLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfF/Yg+Nkb0+cbrEUkE09SiVcqtEJPxyzVCHEBBTq++k9EOulm
	wDZ+5++S6A57aH9hOh92THFU/heKrcC7RnWIX27EcQkbSiEL28dtI51a6VITwwDEp/o=
X-Gm-Gg: AY/fxX5zYLJ3MJ/0drqcOlonK0WkJtdWmkTJVA3U8lzo0613/HNgMEdgs/3+L4hQ5AH
	ztG2IVw75tFhs+vvFbGuP3yJW7dhnDRjVmhW0XGvssN4kTgsgxcmF3LMxJ1unbgpX65UTmwBydI
	SkmxVkxscBMT3C4AweS0ow8IR5aFpHxUdm6/oIsbEMCWsDePa/yhrOy1Rq3ucGhA/7BEQmlEMam
	v94DxSz/i+lfvf/ZmC0wt0RvYhyfN3ss05Z34Bzj93rQQ/icm9fp/frArAV4X5yCshoYJiiqmrU
	ICFKmpi2zePZgwRZTL+lMRNBDULEOPqfBgoMmTy/XltTMRRXb9UEU6DkUlWWMEbKir3xF2Mk7Uf
	AKLxRX0X2+CZTE9Kf7VxB0b2Kuy2vvknS+he9Zb3QYlYbuKrIut0oQQsjVY2VNX4WuHx70+s61b
	8mGqWzXtrpstIN8A==
X-Received: by 2002:a05:6000:1789:b0:432:5c43:64 with SMTP id ffacd0b85a97d-4342c547aa9mr7495008f8f.41.1768479882771;
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a650sm5653238f8f.4.2026.01.15.04.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Date: Thu, 15 Jan 2026 13:24:39 +0100
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
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Message-ID: <aWjch-EcYm7tkF0t@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:20, Marcos Paulo de Souza wrote:
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
