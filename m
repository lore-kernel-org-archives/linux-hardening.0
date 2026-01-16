Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFD285074
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571670; cv=none; b=YRrbyj7qjYXpEDcozb7geNo+95gNP3axzyvqhg7mGGP5DPi7Uemhkxx3y6QJgvnJHqPGlvYrUBmCcN/YR023VWtjJGBulybLGcCXf7qs5540WQhooU091azlYSfCEZMO7h+pe37xzYmx7nXCuO4OBte4zAzkjWTyu+C1bG8Y9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571670; c=relaxed/simple;
	bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcJLsmF6785zCEs/sUYt2S8MGxJw3y9k86n55A5xalymGE6NWINa84svYZRfHLuf1oTrDd6VRWMc2VPFklxyIKnZP1xuCzVNzB5BQXONhfprtDKUXG42eFA7kGP6grB9IykE+l7pQ4Hgz+LPMgbhnzNUBG5gwN36nXU78YXowCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K9BQh4a8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K9BQh4a8"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1465860f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 05:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768571667; x=1769176467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
        b=K9BQh4a8aZ5mcKvc22cHMHLYT6xwWRlRDeFBc2yLrCgG0AD47CVxTHoudVy98hUYOc
         8bz86qaXlX2ZPMbs6RD/y5QKpWaA2GaVWL1SlttExDux1BkhdSSjJGj5/ElT8LfTRm0+
         dj11njKu65iXAGj2QJJmrd4/HlC/cezwhU90d5bCTuuOxZZguFikqJKi4Zt3Q+he34s/
         x546B1I5RhsHx3bVNBC5pay8PP+oIJKrC3sfGWazehRAVlttZgr5xF9YLRMrNBHA/fzP
         SOvipZeJoypOVTD+4P+zmxHD/tNOqnJRl42CfhiuvQllYWg/t6psKMiZNwSnWmO4I2BZ
         kWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768571667; x=1769176467;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
        b=bUo4yXj52LlZSRaRpoEzqOOI6JjN6EeDqCqZB/6TCO2v8K0viAT21IZVPaqEzGrATS
         7vbXxJ937mfGkjldGzRzqOm0vUAAi12dDbe4BqUE31qzaOLIWBBQD1UNZK2rXmgLf/f3
         S2jCT+GvrusEHnJpS7FgupnRNiBwlO3KDiVnhOXgJEGKmQNFiTMaweCtwypOywMiBIpv
         6X4906Sb5KkCB90FI/9haafJY9f3S05vNorYsygF0IzS6NEofpt6ZD11AHXLH9hKrlUD
         XCWvEpqDbe8MjKyUhGPBYZ+UZ0dKuYLmMyqv1F01b/cqrPpGPR9Fk4CzLtvdH7G961R+
         Wy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9J15e7aR3B8LyB8vTCpugXanxobGuJk8uwQZ49kGOsNOJB542Dqap4N2HssLutPhgbC3ULTD8nPe5pIIVLUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pdhOGLWO7GbNpCwsQTHJbJN7wYq1ytT4hvQJdoeTlNkisjCR
	Q2fAe7y2XvC1kXsZyqwF9K5BiJUTs2tNxoAw/EghLmss5+k7lkMcrshhPOv9w3lmEhE=
X-Gm-Gg: AY/fxX7kaS8ed5Pj5a8b2WCv6Dg7ARm1yrlBTRo9Eqd19OQL1MyzhoyhAGF9KGmHPXh
	/QcmhEaKpYPvKvktaH4RnrWm8nNCWXjsPzhJAhGMQHSL2+Obw6jyQY57CBNvLKongtXSQh4pcwD
	NSikQetJbUAZSrCHCwKLSgMLG/WwKIjjrKeO5FRLiKu6BkxefH0uCgiM2gyEDV48aNMsOix52CR
	tbI+PLAixHksjGe/9ihay9n/9WAVCmy+1GQHNbyaiJuEmf0t31dZnFNxmU+WvXktSfVvTeONohC
	Wpeg/0FvWTTC0mtohee/rRKRhiUNSzCRagP+dTG7Az2VUWODshamk+88hHJ6Xgw++nhL+3kB+Hk
	9pRYJZR+9jUi/j/xWK7QwY5pRdu7Yb7OP5O9Q7LBgnn2+TFtUHvbXnj7cI6zjreEQKLGIl9dquE
	hQhMqcj8mqNPYji4HvgdHAGp4Fm3pyyUT5YErE4Js=
X-Received: by 2002:a05:6000:4387:b0:431:1ae:a3d0 with SMTP id ffacd0b85a97d-435699810a1mr3695386f8f.25.1768571667158;
        Fri, 16 Jan 2026 05:54:27 -0800 (PST)
Received: from [192.168.3.33] (97.36.160.45.gramnet.com.br. [45.160.36.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435696fbea8sm5433542f8f.0.2026.01.16.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:54:26 -0800 (PST)
Message-ID: <6168099632390068c8544b48f2e81bf737aa10d7.camel@suse.com>
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jacky Huang	
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Laurentiu
 Tudor	 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Fri, 16 Jan 2026 10:54:14 -0300
In-Reply-To: <83zf6daetu.fsf@black.igk.intel.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
	 <83zf6daetu.fsf@black.igk.intel.com>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 14:04 +0100, Alexander Shishkin wrote:
> Marcos Paulo de Souza <mpdesouza@suse.com> writes:
>=20
> > The register_console_force function was introduced to register
> > consoles
> > even on the presence of default consoles, replacing the CON_ENABLE
> > flag
> > that was forcing the same behavior.
> >=20
> > No functional changes.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks Alexander!

>=20
> Should I pick this up or will you send this with the rest of the
> series?

I'll need a v2, since some things will also change in other parts of
the patchset, so I would wait for the next version.

>=20
> Cheers,
> --
> Alex
