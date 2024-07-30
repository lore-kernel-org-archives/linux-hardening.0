Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC3188017
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359444; cv=none; b=o5rirAdmr/LL2zvLNF1RGjywTmXBeQCmIpj6cg7on6jwfoo5oI0l2h6lGZVETcVXS6EmmrYwvyqRXUBFBEqXqqS7IuAuL7AS+yXf3xmXBqbr9a6mZT40LTe8xlrpOc8ZTkZt/gT2UfbMGdSN2v8JClWj6Hk1cH5IRgHTqN9HkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359444; c=relaxed/simple;
	bh=JWL+84QrTH5tw3D966TBf930YOahS4Q7ArSe5CSZG9U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Jc2obWphy4WxmvsxTkyAk7xyTGacQfx9E+PsMpYWJ/Bcqf9Dk2/sS2fAHEDQnubP1MzL7LXSOTea0dus0lpin33EsdMJPGzdwn/eLnivgpFYTfqDelrlYOtAwhroF8p1DQSWfJcT5v1dQbUN36OkvUB7ShtyQkcEAsz8Lxm47vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=IlzmtGpZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="IlzmtGpZ"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so6733912a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722359441; x=1722964241; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWL+84QrTH5tw3D966TBf930YOahS4Q7ArSe5CSZG9U=;
        b=IlzmtGpZ8ZQn9ZEiqRo+eZxb9fCqwSD1YRUttw75EsLViV2+8G4CqM4gnrKnjG/E/0
         2jfpXvUa2+mosuoIgVr5NtYHnGTEYi1fIMx09Xs3qoQ0Nc6MD3FehRZNLme3f0mA7aZz
         hrO3EQ9DD5UdAPitTUU1UKGyqyn77GOn2S9nLDN+TnKCzzqzSeKJubrROyijmEwFi7uu
         3tXeODamSQ59AVObvGhLIfawx8uXpkieCoWHrEPFa9+onAygG9iqlqrokP4ljY9bPd0D
         svkvo2QVG/FfICEDtjwOC3+zeFrOef2QdvUONBAk+DNwTd0R4q6zPAcwfPHspLRNTsZ3
         6r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722359441; x=1722964241;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWL+84QrTH5tw3D966TBf930YOahS4Q7ArSe5CSZG9U=;
        b=rl5wkXejQpGWSoIIL9bTD8ieXyEQLPCwVEO/ww4OT1z9mddXRfhBEk7nQeWRQunbTV
         OsQXA5ClhLhckCxQdLyJsUaA0lIl3HaVDTDiJ1hGvSEbjvAHJw5Kufeug1tXFhH6MOgA
         4AALzhvXyGGkGi5e0wGivjGBzbyoubtvjaq9Tt3SoWuWZ6U3STg4dDhRysBXj97IbGUI
         14Jxt+iHI3ulzvE4HgZ1L3gLlzhbcGlcrt0zYxPAq9uqKo9tN4VICosvlKx5mIxfFNRT
         Wzg47rDjoRPcKxL25Xd/bbTQHIPg+5QkyzVRfXrSdexiM7IJ9WAKBfAFIqUNv2zyvkVQ
         iiSA==
X-Forwarded-Encrypted: i=1; AJvYcCWGc0WbCxrIcKUL/+QD5hsqwiBQOHHhQhU+lq8bAA5qaxWvwlPXDfLliovGcjNXLWcML7w62rNZTz65ZVAFKuQR89ltwV9tJpYX+GWZR7X+
X-Gm-Message-State: AOJu0YwsjwAte9CTT/yNrFx/I/jL+rvnTaJuXdAQXnyCv9cclIZDUKP8
	wPrtgj4rRORBScmNNk8KcoMFXgjMTv5B2qM4hsfEcErh5IGOm0hwQVO9hSPhIt0=
X-Google-Smtp-Source: AGHT+IFTPXNn+BqzxpI9OZfLChsJzKTraVGft/zSDfoVx0UCP+Pt2KF6NNvg7KkKc/Qq2jHOWr6+Qg==
X-Received: by 2002:a50:9fa1:0:b0:5a1:92d:dbac with SMTP id 4fb4d7f45d1cf-5b0205d4d33mr6436359a12.10.1722359440857;
        Tue, 30 Jul 2024 10:10:40 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10b5:fc01:4198:a192:529f:265d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af2f233be4sm6260036a12.41.2024.07.30.10.10.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 10:10:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] ext4: Annotate struct ext4_xattr_inode_array with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <db367563-e144-4a2f-8d67-d1b4e879397e@embeddedor.com>
Date: Tue, 30 Jul 2024 19:10:28 +0200
Cc: tytso@mit.edu,
 adilger.kernel@dilger.ca,
 kees@kernel.org,
 gustavoars@kernel.org,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <08F6527F-726D-4A3F-96B3-2C3712336D5C@toblux.com>
References: <20240729110454.346918-3-thorsten.blum@toblux.com>
 <db367563-e144-4a2f-8d67-d1b4e879397e@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 29. Jul 2024, at 16:09, Gustavo A. R. Silva <gustavo@embeddedor.com> =
wrote:
> On 29/07/24 05:04, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>=20
> This change seems to be incomplete. The relationship between `count` =
and
> accesses to `inodes` should be adjusted at least in =
`ext4_expand_inode_array()`
>=20
> See this for more details:
>=20
> =
https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-attri=
bute-in-c-and-linux/

Thanks. I'll submit a v2 shortly.

Thorsten=
