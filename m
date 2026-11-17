Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953711;
	b=WPQj+JlrAj+uLoutagLb5mAVzZ+l6qwnZo//taROWBYP+xvaWpeiP2xyb+bodUa6osII
	 s0EGVJCc5kfFSbVsOgePoI2a+viiefy7cKUYdP6pib36dMOA98mD+knDXRhEVc/UeMZjc
	 rx4RW1LYEsjdN5RVjQF53sT8nTVqP+pP6QYtad41ywRWiT/AxYXBPGF+TU48ycQ7AEPMD
	 h11R62zUI5rrEezWV2sfLA27RD4A2i4Mpt6VUk2DSd91aKWruG8HMHZUVFtSi9133pT/e
	 ta8IEqSlpR2ofxbGkjHcOI0UVFkhJXHgd3CkaK2NEJIa2mmAQhl60pqo3k9Za66AXRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=8igbL3DrmgjB8f+3uFsYWHUjBeZpK0nAdLK0B3NxyZE=;
	b=Q4jYT3v0YFuD0r6PR5UISWPR2kHD7naNjxUd8u/pABe/bbs+nAO+EMS/w1Y6t03zgDBR
	 UHzhzfQTkq5+fiuZIjSNCvLGBGyBdTVa186HtinWuLY9+QYfGpiY51lo8a2dlP7KW3Nvj
	 urApFzQzxjDPSf0KLupFqAa6jrzUBb1zv+EVl3Nlx/AHji7yVBH0+ULhrPgmfCh+LYCUb
	 /yR5ln9eySl/4N+HETtdh5xiCiX2pZnVnsNOUoqFpaB4S76BvtunlvdssF0PjeMTnOg5L
	 S72Sso56xeWv+E8VQonQ67cHDTLan4Ep71uQRQqEUX/IyDJHPdtt1M4ZwPxycOQx6mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Omz6m5sE;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1672606A333
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 22:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1672606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Omz6m5sE
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55d03bfd477so3278951cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794953709; x=1795558509; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8igbL3DrmgjB8f+3uFsYWHUjBeZpK0nAdLK0B3NxyZE=;
        b=Omz6m5sEdcCo6i+rZhY1yYYjJkJ14J3/ehViGl2tfjKF8iKEXM6zW6OcK01d0pvglQ
         /FyWYDd3s9dTK874m371PT9CPkHc8iiyhftD6T3ezaFb/DKKKdfmKq8+1bbBRWF2f59r
         pPx0POo1MPsFAIzd4H2wfPc3JPhFi1cneOymArj+Nb7qd6SedaCUb+I0aF3LIjuWBWiC
         0hhANseDZJJQl3514kujAp1eUbsyHKXvuoKsCflx/Akjgi0B/tlwc5X5HqqoixQSbJQe
         qatcOfCVlvQrT6KKtTYaiM1cyk0aObDlkWtUfL4ACKut8n/uzQdXMiEHSkUPiEYiqVTv
         sYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953709; x=1795558509;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8igbL3DrmgjB8f+3uFsYWHUjBeZpK0nAdLK0B3NxyZE=;
        b=EGjR4pRjuZZxqmiKqig4ELzHlIw2YVahKFCh+z6FY+Ql5KELSKDxV6eabt2AJnBVXo
         R1qZO5XxGZl4Nbv0tFwIlB0J4qMB3Zn43YgLLllEA3UgPokPsNnnHrI7AnUc3+bMZCep
         6s1EOLdluLNiCu63VMD8ZdFturs3zu4kMC68O1aRaNglst2Lr+nDFEx/QrQRNb52XuBH
         OPTvycBpYEGkRlo6ivoVo/rbpiuKRKDyhp8kmPKtRMwFd3/2gfoFRFfbQqgbKoAymWb/
         uCoBBBcol1pgUk1BVhV1cW8FhDNXsK2vENZ1nGmCB0EWXpa+1JLg/Hf30/sGCkI2wXvy
         kPgA==
X-Forwarded-Encrypted: i=1; AL+hErEzpmbW+6Ylu6ouMDAZnjb3ORSNWmksCIKU1A1vpKfCXbj1ADVwVx7bqgcTgCYXeKEBso2oeMNwjG+fHknxX70=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UFW9aVAvD8YjLrponeLrtUin/CytSXMUaK3DSMB21h+396xQw
	wlkSXaJNFzmBC06+W2ws2ks6dC2ojvDihwNbusRpqhRhEcmavPFG1M0l
X-Gm-Gg: AYBFou1dsEBJrMBeQKOabTgwjaZYkoNhZLWN1371uDn8baFIZiMUkXPlMMbbuNQXDKa
	YW7yP0cD0aidNddAkhsZ8deIAZ60KxYpf5ewirUTPjU2zxgtIq1Q8PSLVX5Wp7Yp/+301ywuD8X
	LoeGjo0aPSFNFRei0eNGK86YdU7WqPtif6jgO4lAaeYJq2N0RJ7zXOz90o51pdANdkLa4+O/pCs
	CcCBuPdubBau1Tq4On1SpT8pyyE5MMFfN31K1uDy7nvnPuQo5MJwNPrtqBv7M9ccVvzuH2Y8eJA
	54NxF1r4RL/uCGsQ6jkzglMj+Io1YXgEJMlSwJJmC3KL6CSJMyEzblr+I+ZrffGhG6EXQKrwvzB
	kPWcb3XDYLQTMt2t/ysFNvldNlM2zl3LS1cehkS/dpxIZikObJ8xKBDOrZx+cBOufaH3MZxiIkl
	8S/LDKvnlYoHHt7pn99CswiGLNYBU+zywEvRQMyCxFl1eBI3W0hTZBDTeIzgLY5My36vEElJilF
	u4rnu+2WQ0yaMeF1YKTeSdGI6p2YETmEsYruUu/pjKpraJ/rysc0PxfaNeYbHIgFxX1O0Sy6obG
	HD0v1BNPjiOZa0TdyQ2tibblHBrG37fd8g==
X-Received: by 2002:a05:622a:307:b0:55d:1db7:3ef4 with SMTP id d75a77b69052e-55d5a5b77b2mr12272421cf.41.1794953708820;
        Tue, 17 Nov 2026 14:15:08 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d53b7fsm4789176d6.26.2026.11.17.14.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 14:15:08 -0800 (PST)
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
Date: Tue, 17 Nov 2026 17:15:07 -0500
Message-Id: <DMXTZHJA6OGI.3RFGSK5SE9RUF@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, "Madhu Chittim" <madhu.chittim@intel.com>,
 "Emil Tantilov" <emil.s.tantilov@intel.com>, "Sridhar Samudrala"
 <sridhar.samudrala@intel.com>, "Brian Vazquez" <brianvv@google.com>, "Li
 Li" <boolli@google.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Daniel Zahka" <daniel.zahka@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH iwl-next 09/15] idpf: psp: add support for psp key
 rotation
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Stan Iliev" <stani@google.com>, "Tony Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 <intel-wired-lan@lists.osuosl.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-10-stani@google.com>
In-Reply-To: <20261117145522.1910636-10-stani@google.com>

On Tue Nov 17, 2026 at 9:55 AM EST, Stan Iliev wrote:
> Add support for PSP master key rotation:
> - Introduce VIRTCHNL2_OP_PSP_ROTATE_KEYGEN_REQUEST (563),
>   struct virtchnl2_psp_rotate_keygen_request/_response,
>   VIRTCHNL2_EVENT_PSP_ROTATE_KEY (4) and
>   struct virtchnl2_psp_rotation_event/_data.
> - Implement the key_rotate PSP device op with
>   idpf_psp_rotation_request(), which fails with -EOPNOTSUPP if
>   VIRTCHNL2_CAP_PSP_REQUEST_ROTATION was not granted. The PSP core
>   increments the PSP device generation before calling the op and
>   doesn't restore it if the op fails: the op restores it then.
> - Track the master key of the allocated RX SPIs, to report their
>   generation on receive in a later patch: bit 31 of an SPI selects one
>   of the two master keys of the CP, and the CP master key generation
>   of the allocation tells when a master key was replaced. The packets
>   of a master key get the PSP device generation that was current when
>   its first SPI was allocated, which is the generation of the
>   associations using it. Associations then survive one rotation, as the
>   PSP core expects.
> - Handle VIRTCHNL2_EVENT_PSP_ROTATE_KEY in idpf_recv_event_msg() with
>   idpf_psp_rotation_event(), which logs the new master key generation.
>   The PSP core can't be told about rotations it didn't request, like
>   in mlx5: document the limitation and a possible solution.
>
> Signed-off-by: Stan Iliev <stani@google.com>
> ---

[...]

> +/**
> + * idpf_psp_rx_gen_update - Track the master key of an allocated SPI
> + * @adapter: private data struct
> + * @psd: PSP device, locked
> + * @spi: SPI allocated by the CP
> + * @cp_gen: CP master key generation of @spi
> + *
> + * Bit 31 of an SPI selects one of the two master keys of the CP, a rota=
tion
> + * replaces the older one. The HW doesn't tell which master key decrypte=
d a
> + * packet: report the PSP device generation that was current when the fi=
rst
> + * SPI of the master key was allocated, which is the generation of the
> + * associations using it, see idpf_psp_rx_process_skb(). The CP master k=
ey
> + * generation tells when a master key was replaced, including by a rotat=
ion
> + * the PSP core didn't request, see idpf_psp_rotation_event().
> + */
> +static void idpf_psp_rx_gen_update(struct idpf_adapter *adapter,
> +				   struct psp_dev *psd, __be32 spi, u32 cp_gen)
> +{
> +	struct idpf_psp_rx_gen *rx_gen;
> +
> +	lockdep_assert_held(&psd->lock);
> +
> +	rx_gen =3D &adapter->psp.rx_gen[be32_to_cpu(spi) >> 31];
> +	if (rx_gen->gen !=3D IDPF_PSP_GEN_UNKNOWN && rx_gen->cp_gen =3D=3D cp_g=
en)
> +		return;
> +
> +	rx_gen->cp_gen =3D cp_gen;
> +	WRITE_ONCE(rx_gen->gen, psd->generation);

WRITE_ONCE isn't paired here. I'm guessing the Rx code in series 2 will
copy rx_gen->gen into the psp skb extension, but that would likely not
be correct. The generation field in the extension should be copied from
Rx completion metadata. If such a descriptor field doesn't exist, then
the key_rotate() implementation might as well pin psd->generation =3D 0
like mlx5 does.

> +}
> +
