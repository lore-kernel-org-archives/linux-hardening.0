Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149482;
	b=povus/PJy35KUX4tdZfIcI8EBKm/HmcbRBGttHNVWyVK6UuaTA+ew877qyR4A3ObaaSU
	 0Krhw8XdhjII7w9MUq25R/5MGCgeEXj5EKfya8ZYL0Z/L+vLhQtqE1C8YxK/1aHhCCv+4
	 O5OrdpUb2lteUuNDLjhQdOhDJM6+ZF4Uok3E6NTegwTHinH6MQ9l0gQ5DgtkeOYW6kjop
	 aC7OuR8Ys5Iw//nJzpK2vRN8Jx/XoKTdOzNxdnHdmgDQQnrG+kSpF4YrzeiWdMUzmQzne
	 k1FEqUMeL/BLTbTXqZuB7KAEQSI0lUIIIqgqNjKAHJ7CbUQ/b5nAutpSpFl/wlr+JBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149482;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=d7/buK6g7QI/wSja3F3yrr5kbRI73yc4vQHvL0Z70sU=;
	b=htyL48rb1Rt4CZLKHZdGmEBEXA5Aj2bYPnDLHvr3v/qCilVXYQffIvEDg8e4ziT3rpcv
	 /rFdnGsR0BFlhQJOnuxTNuA8xhIEi2ucjJyN00cI5nvYEHIVOHhAp17MrwUFCTfNG4WWF
	 PRpvxc++++zt8nNjH020elVYMKSy/5R7dYLKpLeRDdcHbExbzauNBWsP7Z5p998Ncutwk
	 Dlm30e///dbPh5TKYJ/F2eiBoKD1KgH4uAAzQnj7AUiLAn/MVAVBciG3DBcxwzdgKy2F0
	 6yAurAXdSGPMnYu6HTzRY+QitjWlscHMOiB+Q73rn4Hx0zjXxntHHQkq+gXFdmloGyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YxJ2kPsO;
	arc=none smtp.remote-ip=91.218.175.245
Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82A606A325
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A82A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YxJ2kPsO
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/aPF9fCXwB7LIyQFCDkDmSR064YxzP6iZGZjFNQ3pnE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149480; v=1; x=1795754280;
 b=YxJ2kPsOCbJtqYLGpQI2iHwQKKldu1MSbbpwAO8eeoJ+GwlQaM3iPDOYmy/O5ORtO/OfEGI7
 7byZgsGuI0OMZRDNP7MTqqZNOexvpOlstETOiwc+2XbAouuUgCTw63r6QOSdGJG9eqsL4f7Sj1B
 d2etvYhU3+gLdkOSuS3zGrcc=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4d7de7b7add841ce;
	Fri, 20 Nov 2026 04:37:59 +0000
X-Mizu-Trace-ID: 4d7de7b7add841ce
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
Date: Fri, 20 Nov 2026 04:37:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <cf699b4c6b1ef0e34316d9b67a19082ee996aba7@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 15/18] mm/swap: reuse per-CPU queue readers across
 priority changes
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <c7ee52cc6aa423b40c67d4c24dcb9d30b7e07824.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <c7ee52cc6aa423b40c67d4c24dcb9d30b7e07824.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu


>=20
>=20Inserting a new priority allocates a replacement per-CPU reader array
> even when earlier ring removal left enough storage. An unnecessary
> allocation can add swapon work or fail despite sufficient capacity.
>=20
>=20Track the installed reader capacity and retain its high-water mark
> until the queue becomes empty. Reuse existing storage when the new ring
> fits, initializing every valid ring index for the new topology. Prepare
> larger storage outside the writer only when growth is required and
> recheck capacity under the writer before publishing.
>=20
>=20Preserve the existing prepare/install ownership and failure rollback
> protocol. Device removal continues to avoid per-CPU shrinking allocatio=
n
> under the writer.
>=20
>=20Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index bd098114ee4b..5e5c1aef010f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -202,6 +202,8 @@ struct swap_queue_cursor {
>  };
>=20=20
>=20 static __percpu struct swap_queue_reader *swap_queue_readers;
> +/* Keep the high-water capacity until the last priority ring is remove=
d. */
> +static unsigned int swap_queue_readers_capacity;
>=20=20
>=20 static inline bool swap_device_masked(struct swap_info_struct *si)
>  {
> @@ -241,7 +243,7 @@ static bool swap_queue_needs_readers(int prio)
>  return false;
>  }
>=20=20
>=20- return true;
> + return swap_queue_len >=3D swap_queue_readers_capacity;
>  }
>=20=20
>=20 /*
> @@ -289,13 +291,15 @@ static void swap_queue_reset_readers(void)
>  }
>  }
>=20=20
>=20-static void swap_queue_install_readers(struct swap_queue_reader __pe=
rcpu *readers)
> +static void swap_queue_install_readers(struct swap_queue_reader __perc=
pu *readers,
> + unsigned int capacity)
>  {
>  int cpu;
>=20=20
>=20 lockdep_assert_held_write(&swapon_rwsem);
>  free_percpu(swap_queue_readers);
>  swap_queue_readers =3D readers;
> + swap_queue_readers_capacity =3D capacity;
>  if (!readers)
>  return;
>=20=20
>=20@@ -432,7 +436,8 @@ static int swap_queue_add(struct swap_info_struct=
 *si,
>  }
>=20=20
>=20 /* No ring at this priority: insert a new one at pos. */
> - if (!*readers || nr_readers <=3D swap_queue_len)
> + if (swap_queue_len >=3D swap_queue_readers_capacity &&
> + (!*readers || nr_readers <=3D swap_queue_len))
>  goto failed;
>  new_queue =3D kmalloc_array(swap_queue_len + 1, sizeof(*swap_queue), g=
fp);
>  if (!new_queue)
> @@ -460,8 +465,12 @@ static int swap_queue_add(struct swap_info_struct =
*si,
>  memalloc_noreclaim_restore(noreclaim_flag);
>  kfree(old_queue);
>=20=20
>=20- swap_queue_install_readers(*readers);
> - *readers =3D NULL;
> + if (swap_queue_len > swap_queue_readers_capacity) {
> + swap_queue_install_readers(*readers, nr_readers);
> + *readers =3D NULL;
> + } else {
> + swap_queue_reset_readers();
> + }
>  return 0;
>=20=20
>=20 add_to_ring:
> @@ -504,10 +513,9 @@ static void swap_queue_del(struct swap_info_struct=
 *si)
>  }
>=20=20
>=20 /*
> - * Shrinking the small topology arrays is optional. Keep reader storag=
e
> - * until a new priority is inserted or the queue is empty: per-CPU
> - * allocation must not run under this writer's noreclaim scope, which
> - * can grant backing pages reserve access.
> + * Shrinking the small topology arrays is optional. Keep reader capaci=
ty
> + * until the queue is empty: per-CPU allocation must not run under thi=
s
> + * writer's noreclaim scope, which can grant backing pages reserve acc=
ess.
>  */
>  gfp =3D GFP_NOIO | __GFP_HIGH | __GFP_NOMEMALLOC;
>  noreclaim_flag =3D memalloc_noreclaim_save();
> @@ -550,7 +558,7 @@ static void swap_queue_del(struct swap_info_struct =
*si)
>  swap_queue =3D NULL;
>  }
>  if (!swap_queue_len)
> - swap_queue_install_readers(NULL);
> + swap_queue_install_readers(NULL, 0);
>  }
>  spin_unlock(&swap_queue_update_lock);
>
