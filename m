Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAD182
	for <linux-hardening@vger.kernel.org>; Wed, 25 Dec 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735085531; cv=none; b=oklrPdqqy7EAIr37ruqsJ3iRAzn9B5xuAbaPOtgEUHr++OvppvD8qXu1mnmjOe47uNpPwKZ/qHIdvIj8zFnLxYZlV/lkMADzAjQPhcj4vmBTZsGCXUf5Ml/DoAqndr/Mh1dBw4I5SujL+EwfvIjcBMR8c8d1IUD+qO+JZauW70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735085531; c=relaxed/simple;
	bh=aqQEz69ffLO060AUloP0QtKMe9LzDhvaV6vqYUa50co=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PSd2kCFXdKbq5JfpStg1FypjjL3xOBes7DBr68jzvEy5s6jSapvOZDGOMbKsXT5k9LbwIY+aPCWkbl6aOClLW/d0IzloixB+xZZYIqWkRrxM9FZ3FBM0C09bydOrDDDblNRL7eiGZDncqCJ58bVbecZ993EzSOhhBjTwz4VuwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=J11nNlGV; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="J11nNlGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=protonmail3; t=1735085519; x=1735344719;
	bh=aqQEz69ffLO060AUloP0QtKMe9LzDhvaV6vqYUa50co=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=J11nNlGVO0MjJJ7de95ffDB1tAyZHYd+MdtQhmugwsoAOaNW3OUmjG7Umdd9DlMTh
	 F97zS7VzPww5y8adSE47oLkQ3vwN3isOnjTROCaoNad0cFE00kbdY8Xh9evlLCGVNE
	 99SURrrgk4N0KBHV4sRybaAH/BAGpvmn1QG332JBYOI2MLDJYh4/5zfiWAO7xFbDGV
	 iXj95eNuswt5lgjzhxzK2WQ7Bei40e7PHyZHYxC6fmnU23czoPyC6DU20j8fXNxkhu
	 BXBLsj1+FTJifBFvElKt8KfeIVNNsgXKu/VUuUjGNiiAgYoi273Df5+xSsVMq/7OuM
	 Koz+quz+aieTQ==
Date: Wed, 25 Dec 2024 00:11:55 +0000
To: "mingo@redhat.com" <mingo@redhat.com>
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "bsegall@google.com" <bsegall@google.com>, "peterz@infradead.org" <peterz@infradead.org>
Subject: [PATCH] sched/topology: change kzalloc to kcalloc
Message-ID: <ieLySO0wXjkbKYOTqu2fRbPKXUdAB6xw5zDQedqQEpBKTD4t61myv42eN9b14T6nmoBd6lb45oK5_2rQ9mYKrNCTs76PrDVpLjk8CFf95E0=@ethancedwards.com>
Feedback-ID: 28410670:user:proton
X-Pm-Message-ID: 4a1a081b6666111f8b3515a3da1c822a8b2e5127
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We are replacing any instances of kzalloc(size * count, ...) with
kcalloc(count, size, ...) due to risk of overflow [1].

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded=
-arithmetic-in-allocator-arguments
Link: https://github.com/KSPP/linux/issues/162

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..17eb12819563 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1920,7 +1920,7 @@ void sched_init_numa(int offline_node)
 =09*/
 =09sched_domains_numa_levels =3D 0;
=20
-=09masks =3D kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
+=09masks =3D kcalloc(nr_levels, sizeof(void *), GFP_KERNEL);
 =09if (!masks)
 =09=09return;
=20
@@ -1929,7 +1929,7 @@ void sched_init_numa(int offline_node)
 =09* CPUs of nodes that are that many hops away from us.
 =09*/
 =09for (i =3D 0; i < nr_levels; i++) {
-=09=09masks[i] =3D kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
+=09=09masks[i] =3D kcalloc(nr_node_ids, sizeof(void *), GFP_KERNEL);
 =09=09if (!masks[i])
 =09=09=09return;
=20
--=20
2.47.1
