Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201687;
	b=QSW9P0QYAjXYeWR92rNpUXrelGrUQuYDKQwxuDta9V7Hn9NPVWxHeV0Qkb3WNfQka6ZN
	 6QFjRRx9A9TgUwqZl0p94bnGYKOcJvk4g+GZDCqDWMKSraaht37+y27n6Eaxs7S+NOWs1
	 gfujr2wea1kxVCXenqbeepTitXjtPRqZ0orZuKvI3s6k8dPgX7dK3CRumUd0/jEqCWzmp
	 kPnDFlYZzlII9gohO8p2UgvR/LW+L+czmknilZ1HTCSviy2sLZHAhGYzGVkQVphznrOvu
	 NEWMX4sOMmbzsSlC17qzECzMbuVrjJEgPmfjaLIyvd0PjUZa8atd+Svdj6KlQ/EKfFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JNFgtKDp87voFFR8yXktG0LWODrSokHg8hARj7IkQYg=;
	b=vOW6OPjdbsSy4xsnkP/z4cJ0Rm61QULvsveHY5U769Hn5JratuHftmV5Rs3zTvCfl7VZ
	 94BjpM99/dF5nZWXaAlA7GNridJZYfMWfVAm5F3c+fpeXNfs2v9fjMm21h/spsnfjbp1L
	 +8J7iQM+coOmzFGqSXy2dQNjVjAxp6xseYLHMVT3tPbx1oixfC5GKGr+zmRsJjPgBFxun
	 cc0KwACgr8ZxeqDl1cWXzO96xxFOIaVzsL4UKZ1hwXK997Pi6J5triCZLQOYXbH29hrV8
	 5sCK60w/+715zr7+TkQVu9DT+d6xat4iaTQK0aLz9q23ZWcKfEuJd/4Ew00eZJ6mX2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ef7UxKVo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E71606A322
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 15:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E71606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ef7UxKVo
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f84a55e31aso699950a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 08:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201686; cv=none;
        d=google.com; s=arc-20260327;
        b=BV/CagvjBq9iOGZA1gMrPJSHhvqZczL4miCO+nf0poaKIysB4icP/bbteOwKb2BXuw
         aiVy5wjeLkVM1mx1jL+79mJqJsjjpEoxowHxWFa4sUNmeDakR+XUdN3mSGZHIt9cZ6RS
         76TZ5hIOmtlR/rV+7/tYURuzgA6xczyIbfGwKp9CuJ3dmSwnc8+VlEecEHVprBWXruLh
         dL//KyQWd9ucFtzF92mSI+4CfCPWqDQ/JIxh7WTHXOXz1a+A+KBPmjdTpm+ULwJz4AjM
         zRxKIMxqnz+tGcPMRepHkVBCS+7QxhHEnWydCP7HsUGuQxDc1/uCIN1ANyZcAKRTsWWj
         T8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JNFgtKDp87voFFR8yXktG0LWODrSokHg8hARj7IkQYg=;
        fh=0mUXq3n+eaQNlaldJVGcYT2OCib+nmpNp30cqlK5gVY=;
        b=ozAH4tMP83FhF+JNL6wasET6aFkiOzZtU/K37C/ONOAhP4sSDnF1R0HQ0JlA7WSxhE
         u2jfioxYhRwywnyuAYlze7ePqnjv4ywi8mLPxhFrjnwoqY2Ad0cd5MQxTATIYFDWGUhJ
         XkJ/n/7XJP0AiIEu3F1wmMxm6sbBHLr43r7ptImTYJvPquhl8sqfmh34Rds1Ka2HUA2m
         YBd5No34ooqXJN5aDiL6kQIrI+HPria2GYESUt9cGW4obggeVkaeZ3WJ+RKdcB1flVL9
         nsQvZA2WuMQkZ3NEupzeBLyMOvxb0PdERuSD2DrcYni30kRnFbCK73HYB5tiE6BjKAVp
         b6IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201686; x=1793806486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JNFgtKDp87voFFR8yXktG0LWODrSokHg8hARj7IkQYg=;
        b=Ef7UxKVoG+4kGFp5uykkaUkiMgN1G+lhfRLa/HcMnDuSiZ5htbI+UAqy9Z2N2Vu5x2
         AH+7Nu3jLP/OrYD/VNcTT6FgiRmooO5freMk6bEYmgd57MDL+PIpGjMbnDuc0PsaShxU
         5/3RUNC4r0BI+PdMJjPh9SHdp3hIH597VpChTatGqzIJSzF5YmFX4jXsJFMoU91acv3O
         Ue52hoB1ApBbbh+Buda7XrIKg8nxxtjLMGB26NWAc+iJw/l+fGBuodmpm0fGIbJAA621
         BxIqhM70bRBAAqgrfBdZuKZ1qmZlS/oXwRLDwosHR8d6uPolfMNbRlKOIi4wUlj1PVRO
         cGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201686; x=1793806486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNFgtKDp87voFFR8yXktG0LWODrSokHg8hARj7IkQYg=;
        b=m99IDL2GUsaud2dkd9mYUYDahF9Pu7YZPjkJEjpCXA9SYRDS3eC3z4TKAbglEaEhi3
         7i320JF/BGht4/Eo7f9OSiZxMX/9lLXSZyA8pVFrwvM0N5/g0NDsvqqfYlhmGVGSuKka
         /ytHlYOZHoUhEOAHI0b8BO/G+v1hhjc9aabWncjEaGRM6LZH4g9ll8E9RLoZybFdSI3C
         K/K29tpZ8xxNtjr2H6OMkr5XxkI4STfOYFNxjDhjL+LeMyellJVTzZrXmbHKPI0oGLl9
         GKp/ENKP6EN5Zrkh5cTMCFfM2QSTPpHGe/22h7GwG48tGtS4WZNhowAHESqJyFCywVmq
         eM0A==
X-Forwarded-Encrypted: i=1; AKwUvBz5Q6j5rFzbCV/rFYQCq+gOfR8UzRiZY7L69igCZDSR3HsYXjD38KtntslnDjO3bD047U4d8iTa+ZGxJLWfUt0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfpdCTDJqexP0X4xEF3vuYzJZo0jAYTcgbBosJCsRj39lPLbLe
	e33YJP8VkmevCniid0BzXrkOifo83kpJsC8GvEka0GTLzN7hWVWkh0yhrHnlwEQzd6B2R1tj9wC
	JMy4JMfRzfVZZKpZqrmFZFnZmZUyQD8M=
X-Gm-Gg: AYBFou3iNSKo1BidKat9mkgOFBIq+2L9/Whm/MUPVC91T1RG5aoK7zu02jjTKFQ90/q
	xGKPQ+aDT0sSmMYsD+DAKQjL+wFX27g7mS9GMH9CXJ5NbxwYH5uYAgZz1GGCfTRexLlEwuR2wCg
	kf/+ioih4rMtvoofJ7RbIjzn/QMK7bea6UPrw3HVcBhUTC25BHLs2trZthR1ssYchisCyZuqCpQ
	1NmarL1vfHA9e+ztfoIMVDixhCqvtju9q3JbgvjFtCOu5FkSiWVWqOmz3ZEgRtVllSOs/a8VRS/
	ziKv0NghjEFZkyeMT6CPhp/hY8gBe+B77m2qoUhKwQM72z//60bhIrR5/sq6amYK+uWKe8ABouh
	aGY1rnEvsfWnIeIdyshnhve0Zb0PEgx7kVRM=
X-Received: by 2002:a05:6830:2304:b0:846:e5a3:c8bb with SMTP id
 46e09a7af769-85ac012e9bamr2225801a34.15.1793201686073; Wed, 28 Oct 2026
 08:34:46 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793094611.git.chris@chrisdown.name>
In-Reply-To: <cover.1793094611.git.chris@chrisdown.name>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 28 Oct 2026 08:34:34 -0700
X-Gm-Features: AclHuK81v527zBLgjPgT7UgeAn0ZRsnw4w8kJ2Fr9s5y5HrZvwNULUli5C61ZOA
Message-ID: <CANaxB-zEaaDaaR2Fszx0D4TAcKAapOfcxQ2MzZbFVAhR2n3SOA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mseal sysmap: Choose system mapping sealing at boot
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:42=E2=80=AFAM Chris Down <chris@chrisdown.name> w=
rote:
>
> System mapping sealing is currently a build time choice. Hosts which
> want it and hosts which need to move or unmap these mappings therefore
> need separate kernels, which is not ideal. Let's allow the administrator
> to choose at boot time.
>
> Chris Down (3):
>   mseal sysmap: Add mseal_system_mappings=3D boot parameter
>   mseal sysmap: Allow with CHECKPOINT_RESTORE, default off

This isn't just about CRIU. For example, gVisor does not depend on
CHECKPOINT_RESTORE, but it still needs to unmap the vDSO. Other
sandboxing solutions likely need to manipulate vDSO mappings as well. I
think this toggle should be off by default, regardless of
CHECKPOINT_RESTORE.

Thanks,
Andrei
