Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949041;
	b=fruEunPa1ZUshcy71tY1QIh1mwmaeP90mGeNE+uri+N3wUdMN/aFKfxWk2qm5F7uXDtf
	 nAsQOwY6LoLmhjtU1/IRjO0R9Kapb5Yarybr0CpDUjMt+0vz7JzpBCwBQ74mH7v+3HDyo
	 rHXyStYleUzAIoc2JZ37wEJ5o0tGAeXXaPLJ2iCP5kfULtEOn0JDUS2vpzCxFLFQKzRTC
	 gUOe6Kxlt8geFuQ/6km5dJuJm6OyOxmXhP2DolpkQL8O518ZP/okMANIzfshKYEUxR2c9
	 fr5kgZ6E60DwLSUu9KuR6+2WIqdqAfm8LhJv27l5FaKIl7DNP3maB4KaMbQRH9eLVIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=xJYRSoH4guj+EsNxTlD3hMwy4BVgc6CPsDY4Mrde2lU=;
	b=VXzSP+zMGkuzeEwGeRqi3EvXfkcv3vlYn2FRGFKBY17/T84UICj9kS7TMOo5lqL5Ae56
	 y+Dh1qysBVfzdeOceUYgRjHCb8AIq4kkFGHMGWUqJI5Ppdc+02htWXxdtei1mFQnKEPv9
	 QoRiB06QWQPswjGP7fpzjsqdx3EySAwvHe+DoKL3G1UQLdBesV1IUqBj4XYkj5R5kUNJK
	 U1+7b5X8c0zOsi/iX+C7yEeWfi/hwMlPri35ZULe/1Z2qVp6fJjzaH2Mj8Re1e3Q0ArTa
	 GS3nyAVZdePw8WAlBqLNPG2qtvhj4Kq1oKPwtVB3byxhusvr+pczKtCPevgk/OZIB9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oActs12/";
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F4606A32A
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 20:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434F4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oActs12/
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ea0c05c92so1753776d6.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794949040; x=1795553840; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xJYRSoH4guj+EsNxTlD3hMwy4BVgc6CPsDY4Mrde2lU=;
        b=oActs12/xBkJ9FwqcYoMoPLl8nH0F0LqGDn5xR2oN/Z85LKpMrxDplxdHMCDpntfFa
         lj41w4AvWV3P1Fx8Y8Hwh4jEL019FVOWGbwy/x9vctQbE9NviFebnMyg/qHIWeUutNBQ
         IWCoz6IlyIvV+9t50BqXQ616Grhj49TV6Jrnf00W2kXMONKAASxCA7GcIFTiGajORVu0
         8durIc7MCP8fMMNV59YvkhB7YmCYyAA2LgYdBK24dI9GbPPX085ZCRQuJ5ysKGL4TZui
         luwWfiNNu4OrgYy9LdovfSfjtfHCZI6pnAqOzGYBnEKtEpIUM30yrLtuAcjgFotAaCCC
         nU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794949040; x=1795553840;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJYRSoH4guj+EsNxTlD3hMwy4BVgc6CPsDY4Mrde2lU=;
        b=trZtcMysqvzo0jD2v7K7MgQ/fKDR98zFR17BqX3eiIUT9GnxlGMu8Nit62TIdNkDoH
         AQ6ZDNluMpP8Aa0raZktJwC65d6fPwQnIH+z36SlUYXTINIYIxKBDOfJDx6Cdq5y1l66
         m4NSakiWg2sLQNXhNH0lJ0BdefaNB7ZBG46UH+zQEvBfRHOGaPOG+4HpzRu4Jg531FGb
         G64iKZIQEpAT+4rVj2AXAPgeXjUibMcnRzghAvxqoU9IC5w1rVJa3fMnGk4lkbn/Ol5l
         w5seB/BAO7cuDxPAkdS0X0Yj3bPrZe3MtX0LGNAAK2EdYPGMg8W4cuIrAZ8zuFI3FAWl
         HVhQ==
X-Forwarded-Encrypted: i=1; AL+hErGtQZLrvD2CaCH9pytPee43qzzULyJ35mmbio1o6BfkL6E3EDyisG0rpa3omCYVWFFKZor18gULeBHzUe+klto=@vger.kernel.org
X-Gm-Message-State: APuU4Z+d1pLtIeMgDP2EhgIuEUJ5XVt8A2qy6Hjm9Ic1I8G4iWGBuoX4
	2vZ+iYwiz67/xjirb6zV5BHNwSCoFfP1kai0cMuJ4SRuaq8s6W6jRNlv
X-Gm-Gg: AZFdTZcxuzuzIk31keLJ9H2xzAbE5ymLreDwrVrX9TrHx/cyirmvjvZBEj4fqFnIPsq
	i7112K51hBZF6fxqoTSE4AH6dJxDhDLeyI0Y+FnldYsVJd1Tng+ddvtDDobYR5YaVzabW7hJMUD
	sK49Rodq4PKfdGOJBOgtGkZjQQUhEVqmVpsoHWjPjQ5uYd8jGbzvd3MNbbqng4OQRDHRgzYiaPM
	RNie3QnLOl6kVbkYy2PdgMTVfXW8CwI84syRO3TKdhhHezRajZavsLahKATh7UbYnQG4GODyAiv
	gaMhOF62cM8GblcN8wPXPGUFBMcf/rGsro6GJwLA86HYBHXjm5wLGhYE78eSFOFGz9XiuXViyIs
	Y7O0r6bJwHTBeO4aOqMRW8toEC7NUw96yk3h2IawbFhigc1ii/MD7wch3E9/MsTaKXry7fV5Wgg
	61ciZWQhGxtaKgGbR0XkbHrFca45zP+rqFgnJ3SoS2cfn0LHcNR/grQA+Do1npbJ0Yq5NWW8lyD
	Sxhm1mc/5xpb+6tjyi/FIVF1+oaVLVmT7uKvhWpzYl0u+MwEuhjQLDL2+07MEI8ud9owr0OixE2
	lJGNeyVbNhEwbCWtWTyFUaT+GL9GJpYPerXJOfjGK0e7hQ+U9kjuK1M=
X-Received: by 2002:a05:6214:262e:b0:91c:7c53:152d with SMTP id 6a1803df08f44-92114dd31d4mr7334636d6.29.1794949039986;
        Tue, 17 Nov 2026 12:57:19 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d70c5csm3329646d6.31.2026.11.17.12.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 12:57:19 -0800 (PST)
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
Date: Tue, 17 Nov 2026 15:57:17 -0500
Message-Id: <DMXSBWB0425F.1NVVQK5JZ4IIW@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, "Madhu Chittim" <madhu.chittim@intel.com>,
 "Emil Tantilov" <emil.s.tantilov@intel.com>, "Sridhar Samudrala"
 <sridhar.samudrala@intel.com>, "Brian Vazquez" <brianvv@google.com>, "Li
 Li" <boolli@google.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Daniel Zahka" <daniel.zahka@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH iwl-next 08/15] idpf: psp: add support for psp rx key
 allocation
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Stan Iliev" <stani@google.com>, "Tony Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 <intel-wired-lan@lists.osuosl.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-9-stani@google.com>
In-Reply-To: <20261117145522.1910636-9-stani@google.com>

On Tue Nov 17, 2026 at 9:55 AM EST, Stan Iliev wrote:
> Add support for allocating PSP RX keys on demand:
> - Introduce VIRTCHNL2_OP_PSP_ALLOCATE_KEYS (560),
>   enum virtchnl2_psp_allocate_response_flags,
>   struct virtchnl2_psp_allocate_keys_request/_response and
>   struct virtchnl2_allocate_psp_key_v0/_v1.
> - Implement idpf_send_allocate_psp_key(), which allocates one V0 RX
>   key with a synchronous request, validates the reply (key type,
>   keys_size_bytes, length, and an SPI with a key ID, which the PSP core
>   requires) and wipes the key from the mailbox buffer. The key, its SPI
>   and its master key generation are returned in struct idpf_psp_rx_key.
> - Implement the rx_spi_alloc PSP device op. It gets the adapter from
>   the netdev of the PSP device, as the vports can be freed while the
>   PSP device is registered.
> - Keep a copy of the vport ID in adapter->psp.vport_id, for the same
>   reason.
> - Wipe the RX keys of late replies, which libie passes to
>   idpf_recv_event_msg() after the request timed out.
>
> Signed-off-by: Stan Iliev <stani@google.com>
> ---

[...]

> +int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
> +			       struct idpf_psp_rx_key *key)
> +{
> +	struct libie_ctlq_xn_send_params xn_params =3D {
> +		.chnl_opcode	=3D VIRTCHNL2_OP_PSP_ALLOCATE_KEYS,
> +		.timeout_ms	=3D IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
> +	};
> +	const struct virtchnl2_psp_allocate_keys_response *vc_reply;
> +	struct virtchnl2_psp_allocate_keys_request key_req =3D { };
> +	const struct virtchnl2_allocate_psp_key_v0 *v0_key;
> +	size_t reply_sz;
> +	u32 spi;
> +	int err;
> +
> +	BUILD_BUG_ON(sizeof(key->key) !=3D sizeof(v0_key->v0_key));
> +
> +	key_req.vport_id =3D cpu_to_le32(READ_ONCE(adapter->psp.vport_id));
> +	key_req.num_keys =3D cpu_to_le32(1);
> +	key_req.key_type =3D VIRTCHNL2_PSP_KEY_TYPE_V0;
> +	/* key_req.domain stays zeroed: VIRTCHNL2_PSP_DOMAIN_NONE */
> +
> +	err =3D idpf_send_mb_msg_stack(adapter, &xn_params, &key_req);
> +	if (err)
> +		return err;
> +
> +	reply_sz =3D xn_params.recv_mem.iov_len;
> +	vc_reply =3D xn_params.recv_mem.iov_base;
> +	if (reply_sz < sizeof(*vc_reply) + sizeof(*v0_key) ||
> +	    vc_reply->key_type !=3D VIRTCHNL2_PSP_KEY_TYPE_V0 ||
> +	    le32_to_cpu(vc_reply->keys_size_bytes) !=3D sizeof(*v0_key)) {
> +		net_warn_ratelimited("%s: invalid reply of %zu bytes\n",
> +				     __func__, reply_sz);
> +		err =3D -EIO;
> +		goto release_rx;
> +	}
> +
> +	v0_key =3D (const struct virtchnl2_allocate_psp_key_v0 *)vc_reply->keys=
;
> +	spi =3D le32_to_cpu(v0_key->spi);
> +	if (!(spi & PSP_SPI_KEY_ID)) {
> +		net_warn_ratelimited("%s: invalid SPI %#x\n", __func__, spi);
> +		err =3D -EIO;

nit: seems a bit defensive not to trust the fw to provide a valid SPI.
No issues with keeping it around though.=20

> +		goto release_rx;
> +	}
> +
> +	key->spi =3D cpu_to_be32(spi);
> +	key->generation =3D le32_to_cpu(vc_reply->master_key_generation);
> +	memcpy(key->key, v0_key->v0_key, sizeof(key->key));
> +	atomic_inc(&adapter->psp.keys_allocated);
> +
> +release_rx:
> +	/* Don't leave the RX key in the recycled mailbox buffer */
> +	memzero_explicit(xn_params.recv_mem.iov_base, reply_sz);
> +	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
> +	return err;
> +}
> +
