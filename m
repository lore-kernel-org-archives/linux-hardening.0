Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FE8C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Oct 2021 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B1860FE3
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Oct 2021 11:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbhJQLCP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Oct 2021 07:02:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:60145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241814AbhJQLCO (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Oct 2021 07:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634468399;
        bh=NWbiml2AVqnuk6qWgPp/+YxTsn+eQ0AWnRSoiPOs9jQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TdWVavAm7ozjEAxgHM/ls7uJkmqHSqUuskNeNwOZOd6hGFkCd5qRcwVAiTv+5MB7i
         EPmXGmOvjDDmY9ZPYkVz8gbgPSNYkjkx/JPZGVO+OMpbXZPTjTzPSxgyOK513C7Akg
         Fx8OzNR/I0pWNFXragcIRauZlq91yRxzWQFa3cZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M2wGs-1mYm6U3ISK-003NHR; Sun, 17 Oct 2021 12:59:59 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/list_lru.c: prefer struct_size over open coded arithmetic
Date:   Sun, 17 Oct 2021 12:59:29 +0200
Message-Id: <20211017105929.9284-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:36UFC7rd2IY4gDEXshqcJ3fOj2x/DvuJ/mUvjYn2PPH/l+rm8I8
 MBjuGb+/AviEb1Ox6nJEwy6FocUqGjUJTz8i+wDsM8lgZkeTxZMjXOowaz6B8Pavacxm1AV
 7uQWIkoz1k2lkFWxgjBKo5akA4qTbk/xRzYiIHTP9tKE1Wv/YoubWbqZOFKDTXDStC+35py
 lduX0LWgXYPr1KxISImag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cbLl6ZiQAD4=:/XbPxqtXiyfmf2kB6HnXSc
 vOBFLBn+KnxurzEpmst9rlYzrVa6UZFDshmNJtrDBXI4OhXMXmf/FPpP/Wk+9+eVigfJtFp4w
 9ld9te5bnNn7l69BTfCg2vCyFdcDZZnBub7e0tCIihKmeRQiFJIm0vNJH/zvYII00R48MHQl9
 ZN9spdZ2p32SMUB3TwG/2pcyAsPBP69DRr4q8EAbuscn5TvLKogKnZzSv2rFmJDmfh23wXwKA
 CCTi7FuK4t8uPJDfV/BdvE0nPcU1FPIOJioR+VDuf40Bz6G96hmGx/H9++dWchkWuu6495Vz4
 3pvrn42Ws/LBsyRdUi7Li9i59GeANfht0Mcp7IOf6zwrLbBWZByw1bVlgMNX30JZnnXWT15AO
 RQbbKWou+sgH+tjWSTHwOAGfOOMSXK2XaewETmv9NQRjMtOffgM0yE94Q8eBie8kQ87B+Ekkr
 qeJVdKGLaOfgZzzT669NeZKv2FZWM0h0yAUWRnc4Zne5KVNPH/Q4vVhvfBdGzBCY1NUZN9qBo
 EJX8aGppxmiJvJbUp6doI7XgmMjXK64L94VCKRti5VCPPnv0v26xKcZjEXP10N6e8DT3CBITE
 A9xX6Ui0X+5esuDxzKMgPf/gsMtxpBc+loONj25E5CEn8kuyesOFbN068FvHypZMoU1m2mdF+
 lRWob1QqSauGm4tDznGTKv3VwMn+2ZrFu06VVram28AbXk8WMOOFc+WoVqgUQumg1TUO68jJ7
 Uvdy/1eme4qwmF1MxHMFy49pcEzVfYbA7NCzAFA1TW2iQazVikjpbRovp1XJZTTWrs23muaQa
 FO1IkFGSrBjOEsqlAbCko21ZrTB35800Zt+XnkRGqdc+duSxIaZ2gWYXObsDRIOl76ZL8pkIp
 wxGsiGStgT7v34/FYIzhlyht9JeSsoeO0sCMPB+TA8BpKQikbYw+p+IZ8EAjmhuPDk/x8pwpj
 sogBu1PFgXZQXlOVQTxQjyjEMa4c68HCm3Dkaq8vxrnXSeLpGrSTksjYSS0wV59kup5FJxS71
 +hEdPpOjNgH0UvDcUgWVhFYoXE1XBhNdEQZb+ztMNMn9KQSiWxw93Mj9rg5Q0lAmb1Ysl+xCs
 Nf+R3GKrGLK6BU=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + count * size" in the kvmalloc() functions.

Also, take the opportunity to refactor the memcpy() call to use the
flex_array_size() helper.

This code was detected with the help of Coccinelle and audited and fixed
manually.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Hi,

this patch is built against the linux-next tree (tag next-20211015).

Regards,
Len

 mm/list_lru.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index cd58790d0fb3..a6031f1c5bd7 100644
=2D-- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -354,8 +354,7 @@ static int memcg_init_list_lru_node(struct list_lru_no=
de *nlru)
 	struct list_lru_memcg *memcg_lrus;
 	int size =3D memcg_nr_cache_ids;

-	memcg_lrus =3D kvmalloc(sizeof(*memcg_lrus) +
-			      size * sizeof(void *), GFP_KERNEL);
+	memcg_lrus =3D kvmalloc(struct_size(memcg_lrus, lru, size), GFP_KERNEL);
 	if (!memcg_lrus)
 		return -ENOMEM;

@@ -389,7 +388,7 @@ static int memcg_update_list_lru_node(struct list_lru_=
node *nlru,

 	old =3D rcu_dereference_protected(nlru->memcg_lrus,
 					lockdep_is_held(&list_lrus_mutex));
-	new =3D kvmalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
+	new =3D kvmalloc(struct_size(new, lru, new_size), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;

@@ -398,7 +397,7 @@ static int memcg_update_list_lru_node(struct list_lru_=
node *nlru,
 		return -ENOMEM;
 	}

-	memcpy(&new->lru, &old->lru, old_size * sizeof(void *));
+	memcpy(&new->lru, &old->lru, flex_array_size(new, lru, old_size));

 	/*
 	 * The locking below allows readers that hold nlru->lock avoid taking
=2D-
2.25.1

