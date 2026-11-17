Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936866;
	b=e+0zkh3+fNmFDrZTm3zllhT0CxEW4fH/W56ZcONaL24aUIm1JCtkZzEonVfFiGFhMLHV
	 zAy+4ra9YyCBuE0dhZmP8eqkOb19PfGSdA9oZ1m5ws2ld3waqXgyDAMv/FeCAtMI+Wosd
	 YHPg3UftrxstHaD2+RLRJSn3AA1jfRqOd1R43IIbBDV9P3Cc6A/g0qvx0Yb8hiYh0BsJq
	 hp17gkMTKCAvoAusKhy+MdP7QHaKFJua91xGoEm5utvXWHeiz7THSgSF0gBWbX2PQwxRN
	 VowfW99nptWf9lDmGG73DIszgkikFDqjJvA/f+cAAyuDw/QltG5k2JudvKNwEMWQW9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=pVxrfzsOkS8R/UI8C/+4VKwcJVz62eWVYB27WSqCUBg=;
	b=fbcQQjwgM2bD80ha0JAyptvcTsN3PdMzhmTDDNFITRsDmaPx1BZZKNwpumtSx34Y+xaj
	 nDZSkkWPTQaKmOFoQHgx/VJwe6s+bdFUb6dsSmMUP1aP4ejeZZdHvtKn6FLQnZ6Q8qnb9
	 vcUMjzaEG/2T83K6GkPA8iJD7HayI3COaT6bfImOTOd6UjbPRsr4f09L47O1UnpfvMWiO
	 M8+YQvu7zRy8hOwzQLItaJr+5jRwtMAde2bpj+hLi7MNzkW6TA3BpbTeWYACqDNP3hoWX
	 Cc54337QsTP0Zit5sayDkurX1SazZ+W5n/yMIBFNUVki+v4fVdVvx/g0N/xmQGOsp6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qr7XUmH6;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11AB606A32C
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 17:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E11AB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qr7XUmH6
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f20b304c0so7825485a.3
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936865; x=1795541665; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pVxrfzsOkS8R/UI8C/+4VKwcJVz62eWVYB27WSqCUBg=;
        b=Qr7XUmH6x8Z/p+YdIWnygkcR2vJShVVMJrdU+zOSWrQ5wZaG+5mXDdsYZq65eGEmao
         GbogGEj7gmhDe8I4Z+d96Ba1grCDYluAq46K//hsHcPLjbJFms1SK49YtUu9bYz4ztL1
         2aLBCzCaH+mLAPUwOZo7NeXwmkN5fTptUBwZOC2lidhDC5vNgHQvrE6P0S6BzU59GzYz
         wntVAsKhzTUN1HacDyMFsTDKVnj2KPZ089oSwjY6RjBC41n3xl+mG73QzADcyWYpaOql
         Bh8BciCQXirQzs2Vb8oXVdH5maxlxBPZ1W0p1mDAw1xcQHt3FtrEDW0xM4raCPKzaTcj
         Z06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936865; x=1795541665;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVxrfzsOkS8R/UI8C/+4VKwcJVz62eWVYB27WSqCUBg=;
        b=PJxduSRVEvGi4u5CeCCmSwmKfkzuJin+JLrN8YQjk+QF1MTEGhBF3tRKghQ2TvGHAc
         1DevF9u9UyXSvqJ8DZquBdJsBZ9jBcVtuEnBkCvzrRzKgL6SL+6dyRy9onRnOJemXd90
         MGGeIZt91A4Qwj9nAy03arSFxJTiWJJC6VgNRa5lVPSug7Sd3CugZvKF69AgxtG5e7Kk
         lXYIroLPFSBmlupf0N3qrKf1B4qJ/hHWhQyqsLWvpt7G7nSj2Oi9/VHUDJF3WZ1zH+Vu
         IAr7H8uNi+MREanXI/xydClvBgPTofrgyUDtEs3APimFYRr9Uz9J0gQKSmhYVApToEbW
         UbDQ==
X-Forwarded-Encrypted: i=1; AL+hErE1xOkXJ3nLP7an5ta8y0JLJgIeXo/W/rZg0vGEwW/tlVOR1TKN6IuHWpzaHky6ZEs4GbojfexwlSvPJWhnBXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3OLVQCChJ4+P+YfuLuegUBS1S+zXtNY+Zg6LQRP99oKBc4w02
	KPSyL1iESvw3RDy1r8V7WYEBx6sRNFxGRokqxt81DMVI0KB9dzc/sd9f
X-Gm-Gg: AYBFou1TQnB0S7g+3UrNVAPsHC7M2RTGJodmXg+BT0AebUweC7NlKi1NXlbnY2wf3HC
	nGSE8JONRD3UWDSESdxYAlJ00bD7ZqBeBSIx4banFloW/D4Kq1iALp1d6UqD7VbmmUOrfLmXZLy
	wiBC2ykFjfOBASu8BLAgDtiCeHmzs4rPnOVx40qE/zaxk6h52AeI7wgYxiqR/25i936rchumq5V
	4MHyFrhogLXX+IGML4D2fDgN7zsQRusOPkiGAE38ooQPDhkC//XkMqquKQ33O4ozM8Kv5WYSuTy
	kO+LGEpSwQExDGS85OPTzzSeH7Qh08tiRXQfpB7hm0/UoSx5T04bmun9//75BkF8TszUKKk2VJI
	LRpPF+bD5vdcgwAJ1GfUbrOQvFmhdjPwKEDZcIfNioQeplsLbzWY726iQGCGlIHzGJyTwzPwBqb
	fk6Rl+/PGBfPP4fIh5U5rPBMZa796SagnkdNHHO2JUrXjlf/cuGAHDt9E7cNKeqnoH9QTslpDb3
	OhSTD/ZlBLIbWttIF4L5amZ+fy/fUk5E/YBQvW9kdzphRiF/lft1JVn+2X8WIrnLd4olPXARHHD
	cy0i/cd4YatGCvTvlw==
X-Received: by 2002:a05:620a:1714:b0:949:73f3:83c with SMTP id af79cd13be357-94999572b95mr73032085a.21.1794936864878;
        Tue, 17 Nov 2026 09:34:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7:5db8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c831b7dsm1139318185a.20.2026.11.17.09.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 09:34:24 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 12:34:23 -0500
Message-Id: <DMXO0JIUCNYA.1940X1XHRX6SF@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Stan Iliev" <stani@google.com>, "Tony Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 <intel-wired-lan@lists.osuosl.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, "Madhu Chittim" <madhu.chittim@intel.com>,
 "Emil Tantilov" <emil.s.tantilov@intel.com>, "Sridhar Samudrala"
 <sridhar.samudrala@intel.com>, "Brian Vazquez" <brianvv@google.com>, "Li
 Li" <boolli@google.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Daniel Zahka" <daniel.zahka@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH iwl-next 04/15] idpf: psp: add psp offload
 initialization
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-5-stani@google.com>
In-Reply-To: <20261117145522.1910636-5-stani@google.com>

On Tue Nov 17, 2026 at 9:55 AM EST, Stan Iliev wrote:
> Add the PSP offload initialization:
> - Introduce VIRTCHNL2_CAP_CRYPTO (bit 26 of the other capabilities)
>   and request it in VIRTCHNL2_OP_GET_CAPS if CONFIG_INET_PSP is
>   enabled.
> - Add struct idpf_adapter_psp to struct idpf_adapter.
> - Implement idpf_psp_init(), called from idpf_vc_core_init() on each
>   core init, including after a hard reset, and idpf_psp_free(), called
>   from idpf_remove(). PSP is enabled if VIRTCHNL2_CAP_CRYPTO was
>   granted, see idpf_is_psp_ena(). A failure disables PSP instead of
>   failing the core init.
> - Add the PSP device ops with idpf_psp_set_config(), and
>   idpf_psp_register()/idpf_psp_unregister(). The PSP device is
>   registered in a later patch, once all mandatory PSP device ops and the
>   datapath are implemented.
> - Build idpf_psp.c only with CONFIG_INET_PSP, with static inline stubs
>   in idpf_psp.h otherwise.
>
> Signed-off-by: Stan Iliev <stani@google.com>
> ---
> +
> +/**
> + * idpf_psp_set_config - Set the PSP device configuration
> + * @psd: PSP device
> + * @conf: new configuration
> + * @extack: netlink extended ack for error reporting
> + *
> + * The configuration is applied by the PSP core.
> + *
> + * Return: 0.
> + */
> +static int idpf_psp_set_config(struct psp_dev *psd, struct psp_dev_confi=
g *conf,
> +			       struct netlink_ext_ack *extack)
> +{
> +	return 0;

this is supposed to enable/disable PSP Rx on the device. It should
probably either do something or have a TODO or comment explaining that
the HW doesn't support disabling parsing packets as PSP.
