Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE01494D8
	for <linux-hardening@vger.kernel.org>; Sun, 16 Mar 2025 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742102830; cv=none; b=EOmF2PA8GFKUUJephpr6I7KK+vFfsrmgdZp3L8LbVW2YrPc/AZB/BorRcmE7svc/obbrIcwZmWp2cGxtRISb9gNo4UcaLLZ0Io3HGH7I3kirAICJYAlyPJUt8SETa4sICU/OPzfEOG/JoF8PzY04lw2JOK/LwWOTBjl+num74Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742102830; c=relaxed/simple;
	bh=0/buKCS0+a6BcimPWBek8cGsRNFxiRUcFA7p+fWTHaM=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=gVyut4j7Kd7M9rabky/SXVD4dvRKrAUp78Ti9SwytlC9ntcXH4GulonXXe2dqZv1RwHn1Um03EHYQ6vRh5yyapEP17Vnk9C3i/aRkV1oshE0e93ETDCEKMEgSfQUEDGy8OGBnkFfkPb06J4MxmuiDN8mcsMGqm1e76boNCew++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=yXOcmI7D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="yXOcmI7D"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223594b3c6dso65956355ad.2
        for <linux-hardening@vger.kernel.org>; Sat, 15 Mar 2025 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1742102827; x=1742707627; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrkQU1d0b7NAtHS38+hDA0gTKqK18p0500PEpNc8Ja4=;
        b=yXOcmI7Dz2hPuPUoMBlSfpLA4WNdLozFx1U+p/AHVAMSbN7CJjJD32JLs5XV0IBQKp
         B5ass9TpO0AXDoVvSDHXw2LhK8oM2fW00gjIQF41ZooUWOCEdSDwpsSX2pCSobRPf6+h
         ghgkwjFPUmWB+m2KqYLnjKGu4yh7u8OyHmQOLSiECD4AjxmeGRJRI5iUls9dcIplAaaN
         tG7YDb9yiK9Kvq4C3bqWpsYPpBIh5+wJ0bxExZJAmeVyJiJ4gc4hU7DAwtZxl8JNStfi
         AizScdm/W16+88XUJzuyh6p2g6xD74RYPOO51ZQcZH5izTG8bVIvhWwAUlpHm4xj/l+F
         zDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742102827; x=1742707627;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrkQU1d0b7NAtHS38+hDA0gTKqK18p0500PEpNc8Ja4=;
        b=fAOf/059XHst8n72/XWlCtAQ4qfPvCDcTcBZTNGlDLkDDkH3iEL6XJMuUdyuvisx4a
         12fCNXjLFNCyTvWhUqb5atAw4I45yNnIodh7JRDlkLEDm98R92Tsz4IaHmD+85Y23kcl
         YGv5y/elY93gLvRxBgIHoVjq3pm27/Njs3jJin3bOYsEzMxPWZwDUE76Z/AmAIKLRq7D
         hq+SOjeT4rPs/xAq83CyT0dxBLcOXXgnMZoqBurvpOUsrfr3iVcdFiT9NuaG4rPlBWTu
         hsYVzDx6HQEVAwmqgfZv5nO988UFX1ovAIiAfyiL46OfTMHsA8CVinhr9hZCJJJH+CJh
         fLkg==
X-Forwarded-Encrypted: i=1; AJvYcCWCH6BZfwTednKiBSI22Cdvmb4ZgaxdsZYMms79uKpumV2UI2Ku/vPPvIYfF6RyERQDDJruOggPUj9X/Kv01L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsfH9tjvIOnBM8znkYU/cEDT0t8uAM3hv2omM2OCrAvCRI5Qj
	YRRw/iNBZeoZM3jBNSuuH5PkeNxDFRNh3gH1DFu22cAYDNog8idlGqp9bYT4yd4=
X-Gm-Gg: ASbGncutlrvFoRuOXg02D5g5BP7L4j/2njiuSiGoG+SpKf2SMaiSvVA+lpHMAw87xcQ
	cDYLessqFC6SDozQovG6ZyrbpqV/PniXzO5pRdzD25dTk3GokdsFym3lSMTTTzrS68N6LnXpoVI
	CNRP2WrT/Jq65b89VjisMl9Sz2VZs6KJSLX+nm8XeI9RTqpjs6ccZAnzEBst7kepzjKwVYGO22s
	PQql9asmSMTnSxPrKdU2nYjvSiiko8qukEDdboolSTbPOXZZ7Ss+yfHY54Ks6pwd+Rl1zMEhG6d
	fzJYp3G9N+4PB5vJSBYOioTCDXmPIVdv+osjBo0MKlqJKfiP9ryWoBTOc0cRaoWRyP1vjrs41FZ
	7Z11UKQt9iS2A0cx2Mg==
X-Google-Smtp-Source: AGHT+IEylFL0JknSSXjRKQsBCc0Ot5xAh3Peo21kJo8/AgXmScK41vKcWXeypUDJfEg6NU7oKYk5pQ==
X-Received: by 2002:a17:903:3d0c:b0:223:5241:f5ca with SMTP id d9443c01a7336-225e0a62b11mr93170945ad.20.1742102827448;
        Sat, 15 Mar 2025 22:27:07 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4ab2sm52121365ad.215.2025.03.15.22.27.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2025 22:27:06 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <55E18A5B-49D0-4E8D-A252-DC7EF0BA691D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0B7CE8CF-8C72-4F71-A986-9D2F0B7077A4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: hash: change kzalloc(n * sizeof, ...) to kcalloc(n,
 sizeof, ...)
Date: Sat, 15 Mar 2025 23:27:02 -0600
In-Reply-To: <Z9ZFabmQuSLiwfE5@casper.infradead.org>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>,
 Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
References: <20250315-ext4-hash-kcalloc-v1-1-a9132cb49276@ethancedwards.com>
 <Z9ZFabmQuSLiwfE5@casper.infradead.org>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_0B7CE8CF-8C72-4F71-A986-9D2F0B7077A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 15, 2025, at 9:28 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Sat, Mar 15, 2025 at 12:29:34PM -0400, Ethan Carter Edwards wrote:
>> Open coded arithmetic in allocator arguments is discouraged. Helper
>> functions like kcalloc are preferred.
>=20
> Well, yes, but ...
>=20
>> +++ b/fs/ext4/hash.c
>> @@ -302,7 +302,7 @@ int ext4fs_dirhash(const struct inode *dir, const =
char *name, int len,
>>=20
>> 	if (len && IS_CASEFOLDED(dir) &&
>> 	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
>> -		buff =3D kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
>> +		buff =3D kcalloc(PATH_MAX, sizeof(char), GFP_KERNEL);
>=20
> sizeof(char) is defined to be 1.  So this should just be
> kzalloc(PATH_MAX, GFP_KERNEL).

I was going to say exactly the same thing.
Passing "1" to kcalloc() is just pure overhead.

Cheers, Andreas






--Apple-Mail=_0B7CE8CF-8C72-4F71-A986-9D2F0B7077A4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmfWYSYACgkQcqXauRfM
H+AROhAAiWXg6s59RDOwPy+d7EkZvBkQKCgYg6p5ctt9z4rUHNKISoCw7ysKCDuz
N71b0D8e0dDeP+JWmksKPdSEsiFrCTrvxHbs9sUwAygDtDhzw0IPcqUP00uZvk8I
GJJ9kGompmTgDSP48LCfBD5US/Lnx4MZWlRfXL9VUKify4P+gN0wA8AM9MNkgLu8
84HkA53/5jdw5ya67cJ44mq9YHvLZQ/G+IgldQVU0ekCBXu0RCwmS/jR7y0YjUbv
jAF3Z94bzS0tNAU3bUX4GmmXltiI1FKzFXeVjOCp61mM24AJjvjUYlW+vBE0wXmw
nUPxCry25Drz3u9y1bCNugHEtVj2KXxxuyruJKChANgNh1ctCvaSn+oPUlBVQnZ3
yJIh1Z+/SJK2Cp8tOCC8CEc93i9U6z8rupI6UPfsx/d1wSRQM7PHkJHkNj8IdRg9
tsO4wuyn1RPrY280piHFZE+R75G4Kf1qgZmJ2Z0NVxH7XXrhte0z4cSg9lhLcVOd
YotAgHCJDkDDBl3dRlPRyRzuLU5IfVYU/tHTkWxTstkRl8ICZXZzqvupNn6uaj7O
F8YtI+RrkGVlVVp9AF3HMiIFyut0Wukcx3cB8P3v/dFrgaGd0CO5/f/V2A5OjcC7
Kf8mL6DjlcLaPnGPWi7wZHTtWFSc0odqwZyPeoGhla+g4UHdIcA=
=+78l
-----END PGP SIGNATURE-----

--Apple-Mail=_0B7CE8CF-8C72-4F71-A986-9D2F0B7077A4--
