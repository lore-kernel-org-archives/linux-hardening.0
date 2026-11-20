Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149514;
	b=Jag+G7AzdkUJfN+rP2XPxYqSswQSKajWMUe2QSn6QgGl5ECwYVxp61cIm7YUKOLeXO+o
	 M29xkcj9HMyC7PsQSWUw5UOrzcKcj4r72JEzWh497obGbH+iEZnUcZXXhIZe/wJan5BiT
	 niAidveTDwdtawvGbCSYzdquwK72wysYmxKVcD0oxPQ0cMbL7Ubr+HF/KBsEQ20Y7h+xp
	 I0TjtHnMtJ5BObt8xMBKqLosK5zdWoxywQ11bmDq/JEEGmgGfstWjBeAGqYInvx6rd/0i
	 z/NMlxGueAriAX4Mitp5hzkCmuZrF+knfhqwR4sie0Y4TKukLmijXwU/JSCFt0MYetA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149514;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=Hl0NS9xIz/VEzasBJ1gUTAY2JjbXt21ub1Y2yiyz37I=;
	b=0NH6Lfnbk/UZsFMlgdu3WwpXC9KUhiajnkboVY97XXtpN6Cx+Pmu38bSV+EOyayIWnR5
	 8wEa2dvfj0E91vVrbDDlp0wuo9U4r/5v6jwnRByFB3VRQL1B8/bnctCaKCS96KU6l9R1S
	 TLU9EOaXCDhMgbtsWcGsiLefKZvH7YcDEchKsQdjVxuGdiHT5YRR1fBXBMC89y+PcIOL+
	 2RzswHFfMK9MgXvqH/ZJv2zLfXeYmvXnF2I+i11/5B/PVtTWqvvrHWr58PZxoctoJqPxP
	 M54ySUfLQ3w5LyqZ7eL8FxAhqAPKs6yW6678EPTzWQN4Ia4lUIOCgJAtUtyBM61jzxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vc7k1Xmg;
	arc=none smtp.remote-ip=91.218.175.5
Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6E606A325
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C6E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vc7k1Xmg
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/6TrAmMwTcVMqm7Op4XEd5vSUCQWQ6dLWxvUtJgJkIo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149511; v=1; x=1795754311;
 b=vc7k1XmgK4o4VOUQnhmsBSo7q22dZWqU8NygkRNxAKHkM056bunPPoveIbh+nsrbbHlpyv3o
 ylwuK7De2dyEUWq5GuBCWjlHd2a38n3DzBHU3PQ8P7gUO36hwex1ouPwulyFRHmkn8k+GkllScT
 gZO5AWvYUpTqiHrAnsYSm3XE=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 816ab858cdbf625b;
	Fri, 20 Nov 2026 04:38:31 +0000
X-Mizu-Trace-ID: 816ab858cdbf625b
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 20 Nov 2026 04:38:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <727a9b752cf9ad3658ae8a29a3302f40660c988a@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 17/18] mm/swap: skip reader rotation for
 single-device priority rings
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <799821479a3c820a041d0765fbb70a75598e641f.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <799821479a3c820a041d0765fbb70a75598e641f.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>=20
>=20A priority ring with one device cannot benefit from rotating its star=
ting
> offset or maintaining a quota. Read its only entry directly while the
> caller continues to hold the topology read lock and migration protectio=
n.
>=20
>=20Consume the cursor attempt and check the full/disabled pointer tag th=
rough
> the common path. A masked singleton therefore terminates or falls throu=
gh
> with the same bounded behavior as a multi-device ring. Keep the existin=
g
> large-folio same-priority failure boundary.
>=20
>=20This removes reader-local state updates for the common single-device =
case
> without bypassing device lifetime or availability checks.
>=20
>=20Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 616339c5ae5b..0c192844b121 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -334,6 +334,11 @@ swap_queue_get_device(long nr_alloc, struct swap_q=
ueue_cursor *cursor)
>=20=20
>=20 /* Consume masked peers too, so every walk remains bounded. */
>  nr_iter =3D cursor->nr_iter++;
> + if (ring->size =3D=3D 1) {
> + si =3D READ_ONCE(ring->dev[0]);
> + goto check_device;
> + }
> +
>  local_lock(&swap_queue_readers->lock);
>  ri =3D this_cpu_ptr(&swap_queue_readers->ri[queue_idx]);
>  /*
> @@ -363,6 +368,7 @@ swap_queue_get_device(long nr_alloc, struct swap_qu=
eue_cursor *cursor)
>  si =3D READ_ONCE(ring->dev[dev_idx]);
>  local_unlock(&swap_queue_readers->lock);
>=20=20
>=20+check_device:
>  if (swap_device_masked(si))
>  return ERR_PTR(-EBUSY);
>
