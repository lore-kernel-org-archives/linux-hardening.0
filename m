Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E827FD5B
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811838; cv=none; b=i0y26oMVc0wEx6JVnbS3B4FBBfvy4G0E+ULJgPNsYaMgExsfa/xGpmBxIDizhtFMxg2bNsr7x3MIkGqqSYmUT0F9YMSD6p6SaRKmUDikVzs8IGTHc1fj+pBKcK6/jXty7svA0D98p5th9qhuA782jl1k57nzARYrwNParodMcOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811838; c=relaxed/simple;
	bh=tFz8mxWmtvp+OLRSVyZYdPXZ40EOLiMevSfJIuTSZIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASY70WO0SXhnMtGiIo/MS7EBGsVudXA+K5J45ZgCVjcgZdVipexBN21Vye2iBuVCkGHJ1kaHn1M+B3ZKrh+pEIXINOVgPbgzUwlazSOR3UHAipECOObkzy9XKCvSlSLRHsD11fBAG+qSNhiV0JT2hrxpnrZ8XpEalHv0XEshzeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TG1LNgkq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TG1LNgkq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d48b45f9deso1491855f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756811834; x=1757416634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkjdJ99tSVQ09kKrtq0hv3IjTswl5kKM4uWkHH+xt00=;
        b=TG1LNgkqLtq9cIfMg2TppFSf7wDvWXZURS7bUn1zsAXXeR3nyDMz/jckkqyHVzGlj2
         EpJh0wN5eHePSXUV65F2EidnCCVvx7fofkNmL+j1uvsxbLWNXvz0NO6TDjBNB7QVAN6m
         y/9vDaHTAWhBLHOXcqEfg6DN0rle7qcoOMpi4wouoGT9Z+O8S+akwPqQxDsaZdC9+Dkj
         Hl37AkSXcMqFFZw5jSm2XiaDsPFdkUblK1haJtxCr4SA41/XEXeNihBa72aplEgySu0x
         dK42F8wLBJQ7zI7IArBWsUBq5d2csaCvesL5/GmrIA9SiKis+wpqFamZxMNpuuij/wQ6
         pgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756811834; x=1757416634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkjdJ99tSVQ09kKrtq0hv3IjTswl5kKM4uWkHH+xt00=;
        b=sSL8Z7iSNzbpqwVlcZ43Oz7ay5l/5oyJhiUti6ivJBPKzMJ64XapUmEYqYtcIpKl12
         3Fz6cLZb0+EFobtITtzpoeQvwgBBsebKR/Iu6m1ZYQdv6u6pfK5CXeOVj86A3aHAxvKo
         6oIFZyLy0Ue2QBt14v+5pu2vaHv0wWwxXfa6BdUt6lIBGNK5YiOOgmSWGi0t2ZfSANLT
         zlmK3FqJKrpNkZfjBhWvlnDazc3Jr4yzRF9zQGjcUELAmgYhcj1TBcv5ozy4xrVQ+JS4
         jL87lanQfWf7fcJ1M4p6H+TSnd3uFnEtwD/+/xKLnIe6qTa2aHMpYANl4fFkX2Maz7O1
         iaBA==
X-Forwarded-Encrypted: i=1; AJvYcCWcFQ34dGKTIbPkN926jfeLE+rIwXBXsd2XhxNgFZ5utcmpIkEIXW8HvCvT8SHIWKBD3v1YJ0K2a9Y+M5M9C8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80PbD9DXv0ESpBWFVFE9hUUdG9D3viMgmbsegWsydxJOzbmU5
	szfY9f9YmDbU/9f/JIVUMUu7AuCZtdROj9uwDBDNUnt/NAbdPhAUTz/VOzsV0S5reWI=
X-Gm-Gg: ASbGncuMgyy++D7ex3ngmrM5/d4Yiz1cG7YLmfNZJEmzYbq2mihRSnwLsiFo5+ebAaM
	2LoMSYTy+gtm7zQky8xBoxNBkxDnlw5DIx4KPHbBkCHIXYRh0YnZ2X/5i8bC3QNx2q1Ao61pLiq
	u9xlmiQ1U6HFUjgGY0PmETEEgiERVLImlJCbYujTU8b0pWHASUYv5+MipYFhenzxAICNuvWT9Y0
	TzkyWzjYECehUV4l1ndGcHpWyvPnkEfEF9DT5HSShd+cDuDJC8PfEEdxZPUBgz/hrlNBkpEgks7
	E+OIqot41nHBfUVIRTjyQjQ4uVHaupBoKU6yUOJpJhdPr8ZVCXbCbYOFaYo9XTgI2rtPxCoStsy
	TDobiW5l2qQxD18W2a7BLN41DWrBMzIZ+mp5txlMzvaU=
X-Google-Smtp-Source: AGHT+IHz6YILuOaZ0SJzkFmlUROnxTGIZnMil2cOBLxZw94mqhQOg5dIe1n/6BlQbAypfFTe3xtbTw==
X-Received: by 2002:a05:6000:1ac8:b0:3cd:5405:16e7 with SMTP id ffacd0b85a97d-3d1de4bc31dmr8130862f8f.29.1756811834120;
        Tue, 02 Sep 2025 04:17:14 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e68c83asm207225375e9.20.2025.09.02.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:17:13 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:17:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <tl6b6chfawtykzrxlmysn6ev7mq7gm764rnlsag7pfme7vhpof@lbwqooaybqmr>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
 <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
 <92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jme3b5n5ad5ko2pk"
Content-Disposition: inline
In-Reply-To: <92912540-23d2-4b18-9002-bac962682caf@embeddedor.com>


--jme3b5n5ad5ko2pk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 09:56:34AM +0200, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> If the increase in size is not a problem, then something like this
> works fine (unless there is a problem with moving those two members
> at the end of cgroup_root?):

Please don't forget to tackle cgroup_root allocators. IIUC, this move
towards the end shifts the burden to them.

There's only the rcu_head we care about.

(You seem to be well versed with flex arrays, I was wondering if
something like this could be rearranged to make it work (assuming the
union is at the end of its containers):

	union {
		struct cgroup *ancestors[];
		struct {
			struct cgroup *_root_ancestor;
			struct cgroup *_low_ancestors[];
		};
	};
)

Thanks,
Michal

--jme3b5n5ad5ko2pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLbSLRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiIAwD/b00l+aVBPRUgP1zHehty
uF0kty/XKqKmicCz61ldtxcA/1riA1X/290Fr8aUbMO/YyrMIhkgpxSWHh+JPrSl
/WQC
=0maq
-----END PGP SIGNATURE-----

--jme3b5n5ad5ko2pk--
