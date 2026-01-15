Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B5361DDB
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472200; cv=none; b=aFaYxQctelyaoyrENs1HBSw0LcEUocioVzm3JRj9lrNR6i4IvdosF1pQx+yxg0efrFFBivDnFH6kX4KoHWK/8oRBo3FHGDdmJBkF3GjPpCKiq4CWwwskBmeRqQO9Z4QeYKbYPWZt7TrRPzmVkvbrq35ZzqN1zHSuRCkxnLdu03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472200; c=relaxed/simple;
	bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5WtWgKAEYHEydSGyRLzub0j6gYWMFWlY1ITN7mErGUjKnECbzLiraeXqTWVOuOJF1fQ+hliXjxFXobBbFq+cwhKFBvYAHiJYyVIAJSA5fbfpE59JnG+4cgiA5UE04eL35NyHjDbdaLYz2J0r2FxCfcwYwQjVw4kKB/DQfhullk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O1AfzI1f; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O1AfzI1f"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso257985e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 02:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472195; x=1769076995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=O1AfzI1fLMDVa3SD3LO45cvIiavE+LKVM93UrB7hJYcD0m6yOptHdhokkT8bTYka6C
         3sXJ7mv88zLWCKOA1K4tTNEUpgl5sRbxQkPkY/JxJ39NJl8UGOMFq8kcmDmf/klRNfzu
         nJ2y1cuRJKr4oZuTg+fls6YXgf7Cmk8scFvR14UdHkOvJCMLVgfHdOWaDArlFHS8i+in
         /rjDe30x+8k/vU2nriXmVzYvgsK75zbtsHQliWEWoqaCQIzSRCmZBSVIuTAHgBAk/qqa
         BhvMnVF7Ni7MX4Rr/TPuFFrwopkxq3IhJQiQJ1qEZjzsylkwRiXGFMLOKcT5/GAwd0bX
         FnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472195; x=1769076995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=e9rhxo7TOKe7S58C2cuBd+Ohu2kR+oiF2MjZB2TX4c+kZYkGP6UjYHQsqTrgjvuv9v
         qXTES1xCsCuAiDQTlFSDnqq1Z/DXz9EOzGV150xOZRw19Ig2u1JuhHPN3HGOgxTMpAp2
         g9YccM+8l2/iIq8gDJWqYEpAE3ErwaOSjy8lT/tDKZMT/iqKNLBZ1q9ZeErCMnKlH+Tk
         VK5QKKJ3eJDgtWWTSq6X4q1SP1JHJwdhlLqkUVODzLLgiBtKFSiv7xdgXY/skMCobURd
         b2UJqd0eQ56kGVVIXZgonyU0vaw0/vt87ljxHwJtX8db8h6ir3gKYm4fIkBCeMl7O2kL
         CItw==
X-Forwarded-Encrypted: i=1; AJvYcCVb9GN7nRmyiJ1o4553SlM1Q2Y89tsGCO4iySuNCkcDGqcdxqXlSjOaG4y1QbtR5WR/dc+XFyLySxK8unPyxWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoEK8le9gRRrmmBlRqvcRK9enb8DGj5BnFEa0AvXfDWwnctqA
	uetphgPfHESBl1Hr6tdlzfGJZOqaH2KTWxtw3Phh0iduOlGeDOWT0cUy/mF0nyUtV1w=
X-Gm-Gg: AY/fxX5Kl5u7LIZm7uIUGNzTfmqlYgvsI0fafwfFkIX9mgw6v/NCO5rjWlShkXDRO0p
	OXZU4OWQc+/8FNgr5riwLrvm5vQeb4jN4qrP6kY2V5ZuRTgE8DhySaHkE3GvR7CuRjBGf/cWA0i
	y5uCbmaOVUnL4PpVT9W04Z/GXbSXAPob+yo8FFVMH/wXUWL7PDtL0Vh8AAefGhuohbNv8vtELVd
	TOSCp8yEjt0potdf0QBmwt5znMFuyjmrlp4vraqLJ0kTwZDTLuFaVJlNxtUHolvUJV5y0VHn7ME
	egcW6WjZ1bupXIMUTt4qozjUBvMhki7IlcozOd90bt+FQmaJwOYFz+B2ejXXvOZgfawr/Lst3Gl
	t73gqWfPM6PfdFeH69VEsPczoDEgQ4/RZXTBEw5WmAjETEfh+EzNRS0fEe3uv2vC+84huckhUqt
	WjUpBW8VnBHLx2xYJTeoOVrN5x
X-Received: by 2002:a05:600c:608c:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47ee32e0829mr58296485e9.2.1768472195426;
        Thu, 15 Jan 2026 02:16:35 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee28144aasm39739585e9.11.2026.01.15.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:16:34 -0800 (PST)
Date: Thu, 15 Jan 2026 11:16:31 +0100
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
Subject: Re: [PATCH 07/19] drivers: netconsole: Migrate to
 register_console_force helper
Message-ID: <aWi-f9LBJtxGWgWs@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:14, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.

I would add "No functional changes." like you did in the other
similar patches ;-)

> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Nice clean up!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
