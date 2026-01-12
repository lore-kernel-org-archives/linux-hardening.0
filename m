Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8637A4BA
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240414; cv=none; b=Od/4BmpACJxx9Ft39F7VD5s8JaB0Y3p840uKkVfd1gxMEO0pr30V9H8LP5Cp1xrzF2Wtylnr/4tfvvB/ptPXpqrpypa8xA13jqKAK90yb7QkKaLuqsLWGiaKW6mX986YFm4Y/tVjYKptoO70SVvV7UVShl3vVaPnpiBf8mq9otY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240414; c=relaxed/simple;
	bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXLcuNGU7O6E43WPIWN4Amc0mUf7ZBddJJFr+gUDkh5S7Z02TRIvCX3cQLoRrd02UQ/Jtmnv7Hrzzm/RiIU19lgN0XNU5nn45Vv4MUIRVAlGwiRifa293mEaO2xIkau90EBFwgoqoniCGqmM904MWoOWe4D6J/2YqOq6si/dgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HIrT55Tp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HIrT55Tp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477770019e4so50561345e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768240410; x=1768845210; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=;
        b=HIrT55Tppvg0XFYV5zS20v5xaWtuqbHwmR0+5GnSOqV3Zkqr+5e4bRVOWGa7T+G+dc
         d5rshviEoUDadI8tfAjFRPSFxopu/3PZCFonHcYWFfwYqBaRD1P2ccUPAZOw57poJIgk
         2o8Rq8MaIxKEDfVpi5OxW0oI7odIOVqyt0hNuhOTtPiDtjFXs91fI/lOWlNPLoY/ZaeM
         mV7icrjbWluhuD2o9cvBSF4+skVjcVoRRmaIlc9BDsb4AbDqtsuQdXMpggf1CiXHQlfo
         0FMj/pO63Bpync6rTiNgO02fKipgreSs9DrEqYwDCCSf/g0s+4H5xMDOF0UtZgbuZmby
         4Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240410; x=1768845210;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=;
        b=xGiu39hve5hKC0BjDfqFbc9ObBz7v3W0MptGpMyWV6T+3EUuPlDOeV1WNuQ/ZT+6Qp
         xL48oKRk3LuUhuzUaph5tt4dfAZMnAntyw/LA1S4AChMUDlefmYCm0DHmJqWovQFu2nV
         KiF+tFW9M30Yp69D+dy0cqQ9UJAjR4/9jVREeekS9+uqGXTiXVLqVztX0gExqGmbvwAq
         OK9trxMH8dfLYLfZ1ewLg1hKjvAL3JbojSKPmeDIbrgEPOrd0puLQGq/5UmiBJvYrLvb
         84Hq8Vx/jMuIB+qRKcQWJdwZoi1FWqUNFW0PHbKRjMlgSgkFwEi2R0gJgZTe8xZC3OmI
         Oleg==
X-Forwarded-Encrypted: i=1; AJvYcCWuzlVCDtYPpc0NCiErMiDwmiLpu7JVso0XJnwU3n24vq+vS+3hPaoJ+WO42cj5lb0QKn1Ex03cwm0Asi99Ew0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxE2gox8/sZ1JXn2PwHHYW2j8qyb4cT508xHxPNSxEP/89Zpfe
	DkDbohrvQwJ3KIOXLHSnOqi6mpgx8jltqhD9m4X1+4bBLohrnzniC7gN1Fu4GkyrCnM=
X-Gm-Gg: AY/fxX6VrediM2L6Qlu+0Ie23BksVz+imnwneugLNy82Gd/Ws/J5RAe/D1HZ+V0tRqR
	gohT+gu6WQDZsw+7w6uX5obx9oItOcNk5K6w0bHnBAG5vG5MbfwnJwRL+RMUqlLHJRwTABPUaw6
	5B4Bag9zrl5dgRGGY2YxnCLYogN6URHDSSY2+jkX1qW9TSgwvHvWvjo1QncS/Ss1o8G53j4jfYM
	8EQ9fDj8hn9wF85uYQCh2T1pbvRQUDQ6i7bk/Hs3FZH1PQjl6bRpP5gzcTf3tExSzvuAsrxPE4n
	UDXl9FYMIoUqwxVgJnFEdS8W8aqnbjycrzwIwnLh1vTzLZwrEt9Ee5xNWRVQCYaGqsdDlm+l/4+
	pgOUsboICsVrUD1vwAzTURNt1K/VBI44eSyEkazPVY/6lmb1Sx6bpKtalYQ6YsoIQGSLdsUpswC
	wsUHQ/QEsNOv9x43vXgEQxtdmZjzPjlrvkCUQRsdRnBA==
X-Google-Smtp-Source: AGHT+IGfCgsoYudB43gyY5VgiMyajRCyMKVvdA/K1TPc0FTW2J7Pqnzu3xNux2u9C7uenfxIM0LM/g==
X-Received: by 2002:a05:600c:4e8a:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d84b170famr247229235e9.10.1768240410449;
        Mon, 12 Jan 2026 09:53:30 -0800 (PST)
Received: from [192.168.3.33] (218.37.160.45.gramnet.com.br. [45.160.37.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e13bsm368953115e9.7.2026.01.12.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:53:30 -0800 (PST)
Message-ID: <0585581cd2f19544c5e1565a9d241697d812b5f9.camel@suse.com>
Subject: Re: [PATCH 00/19] printk cleanup - part 3
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Andreas Larsson <andreas@gaisler.com>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson	 <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek	 <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness	 <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>,  Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Alexander Shishkin	
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin	
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor	
 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Mon, 12 Jan 2026 14:53:12 -0300
In-Reply-To: <836139d1-1425-4381-bb84-6c2654a4d239@gaisler.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <836139d1-1425-4381-bb84-6c2654a4d239@gaisler.com>
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

On Wed, 2026-01-07 at 11:22 +0100, Andreas Larsson wrote:
> On 2025-12-27 13:16, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >=20
> > The changes proposed in this part 3 are mostly to clarify the usage
> > of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in
> > reality
> > the changes are not complex, and as the title says, it's basically
> > a
> > cleanup without changing the functional changes.
>=20
> Hi,
>=20
> Patches 7-17 all say "replacing the CON_ENABLE flag" in their
> descriptions, which should rather be "replacing the CON_ENABLED
> flag".

That's true, thanks for spotting!

>=20
> Cheers,
> Andreas
