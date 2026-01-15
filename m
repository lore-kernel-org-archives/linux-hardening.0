Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3335FF44
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472790; cv=none; b=iyAw+gyDUon2o/mo0KWWk6EJxiwOqtaFQG+TfkzFHuFuZmXbvQeM0gGcinhnWQHstbC0O5SxvTJxZo9P0f0dnSjo6WqZcV4kl+u3hVKmwRsYTVJgK+sRaZZKRwIQGeJbXAtCzcZpceyFJHS/bAnaKKLrsxfbVUt/yAHkLwZ70do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472790; c=relaxed/simple;
	bh=cTvHKPGvKDvdv3CW2phXagRp3ofYcYf6SwlYtKmyZc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ1piay7tCNnmWMrQb3qMmQlY5uTMn2I0dHa17Jf0962748in5Pm/gW0lWodli2ohqE7mwQivAsFj0AvZBxxvY0Pq2Zpmq9FzugjHsQtOzOIiSZcwhrN+EeJDqJgMHiYnxPORQL2aWlc+gD89U/+8k/WMj9ktWXTcYrQv4w5EyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/1izd82; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/1izd82"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso4746495e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472787; x=1769077587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLly7CGERK95lIS5prsdJ95HAbwiiwFAFGJDvTd/YQs=;
        b=J/1izd8202qGaEeoRfsgTbdNxGufyL/cwhFUjAPYTm0bu9tQpJGJoov2DY7UW3yv+k
         Ypk2IyteZoLy0Ofn43OPQzcJVdgCeFDdQROt5G/Ewr6MOecTqVDBDgQ+mtU9x0UAGyP2
         K+Hc/kMSUrrtITjz1+pKJas3OsP96nR2f7CQ/7VW/vygG1IugjSJNRCp1bJNrtx1XBNd
         lPade4Vb8ZX+T5T70bvoHGBQisN85xX4JdzqvTH7CqfVIah5867/eoV1gJgMA1WWNRti
         0RHH0X8T51pG7D9cK58LNI7ZdVv4wubDbEgPodpVF47rKp4sEj9URWJac9sTSlOjNXYS
         C4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472787; x=1769077587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLly7CGERK95lIS5prsdJ95HAbwiiwFAFGJDvTd/YQs=;
        b=dEmlhurJUfSfp4FYsq4s/3HxKPFjL+lGdMlMmbt6NcUEJDX8DywwKZompmB5ES9Clm
         QoEhnpKyTUx0I7us3H2fRNOqkomW2x1usJsXe8gHOrVSBAKd8Kothxs7tgFHWJwxLQ38
         RwiXui8hMXIOYjgG4mv1J/U6szUtYJ8FbYiaE9UsUQ/rwb9v411XYmmo4D2sOpFwEyHM
         m8f1BaM6UhRpM2NsuJPDO871cMvheUiyJChBGJNBLFLgf3OOpAxWU6UUW/ZfhqmpNy6M
         Xf82hvZeAMAwSF0/MQZLU+tdjVksde3aMLaT0bJjjge0k3f3m+xX4B10oiXJuI2NW3HI
         Qlbg==
X-Forwarded-Encrypted: i=1; AJvYcCU+4YLqNvbHhZH+9EKbWQaox+QrYb5MAFKRHozm+2Oi5/ckDa9M9f5mZeVSTxDp9IhlZAxyBY9Kh+NlYBAIfac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6vBIRnH8dPGKbuIg8ehtBbxvjUa4YooRs6WoTDMqJI+Z21+y
	+H1XYUPgR5m3dMmk0A1ZggJ0CYqYTo43msydFduY6I+J6VSbP/zdbVm+uvUfxN0ZBB0=
X-Gm-Gg: AY/fxX4M1cTH5zFRLwb+4PMGdL5DVf86pSdQzz/UPpxq8m56zfrhy+9R7D9+0nRWLlu
	axxkeTQE2Y6/cf+3Xnxk8d8BeIsCAeWTp3yV2UoimkTBXi7Zrs/MHzk+MD1tqyM8O4d1UfJVhst
	eJ7j9V5MDEINHklg8Nh4a3Jcl1KWB0M8/R9gg5KavhW2r2pjWehBR4LKGbC2KZCOdv1ByTaE/TM
	EVxZoVrPRDLiZLgbweU6gU15Pqfw2k9wMLha8xqxAaT3knwInwrAbEaVLBh6DwjPpK2DhIciRC7
	Vr+43lze7F4aGakTLn21r2OLz0ej1dQ8vQ5rJPFuIDOpuTX7WGoBBQL1iUerc191UVxWpymWrWE
	cdCPJT5Iu7vpYv7oP0q0BI+cZnjYAFuWokYuADwizUmdVMco1KL/2gQi0EDmjDfch8FtSDTECns
	NxblbIIjpNVLLS7Q==
X-Received: by 2002:a05:600c:8b77:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-47ee4819d6emr64067955e9.21.1768472787399;
        Thu, 15 Jan 2026 02:26:27 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d90aasm4935338f8f.29.2026.01.15.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:26:26 -0800 (PST)
Date: Thu, 15 Jan 2026 11:26:18 +0100
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
Subject: Re: [PATCH 09/19] m68k: emu: nfcon.c: Migrate to
 register_console_force helper
Message-ID: <aWjAysWXHUOHSisl@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:16, Marcos Paulo de Souza wrote:
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
