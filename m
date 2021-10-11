Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3A1C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Oct 2021 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110DC60F14
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Oct 2021 10:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhJKKlf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Oct 2021 06:41:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:45911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235915AbhJKKle (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Oct 2021 06:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633948766;
        bh=gE3WDMuqGE39JnYoasU93YDWlOoPTsYZPI0m0z1wlII=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FpZsDn1GodNYeYo1gNW9V7skIlYt7SGOCaou5GQ96pXcsryjQLOLp/sQv/V+tjF1k
         OwUEq4hHvXm1MkXpRAjOHFcF3xCM99almOzLhRaauI4DXMQdMWHQezWdwxfIkTgKOF
         oFwGbJfMS90jym4dD31EsThRiL4sy42c5gFS/8MU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M1HZo-1mcdrr448g-002mAe; Mon, 11 Oct 2021 12:39:26 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Fei Li <fei1.li@intel.com>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] virt: acrn: Prefer array_syze and struct_size over open coded arithmetic
Date:   Mon, 11 Oct 2021 12:39:02 +0200
Message-Id: <20211011103902.15638-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jLpt3mF2cKN3Zhc8hfH+cIgsyGJiEqwmPz2M7LpV3ya/e3tEhMr
 kCa38ruwuuqwzOa9Gv125IbvHH2X76yC5of6iRe+AImDmae6KISIlN6Tu1hDYzT/nrHskZ7
 GvMiHLF7P7wr13dCBV6V1wP0sAJ5xCGL65pzGEUHus5mZGa2QsQcAPP2G+mVEbKnfn+ytRH
 K9qoDrPE1A0pES41T27cQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gRx5sUq1pB0=:7GZFwz/w5DgwTBIHVa5N44
 +puAnmGeURL6929uQfcwR5KAUwIrJGVK+9xYmEPTeZZJ4cBLZawjcMTctl39Nd/Hi1m2Dh17h
 fCt0gL+d7PU46Yt8+idAWrLSOJjHb+yHFiU+igeqXa0Ld/iTe3m+i+85XbNeiYDZH5jfA2o9s
 olCXHZVVVPInurIscwwNzf+WuF5/mrZUTvdg3xD2mlUXYIBy6FWxp6y7XPv7AKQTq4J7z1zmk
 9zO5p/txHTyNYeM3Ksas4g94e336oS7xPaS9dZU9zhQ2vPzHxMDoRtVFO/NDIuhe9IvPZw9uJ
 XGU8ohMpL6sj/HrxkAPGmUhwk+prTfMeMBCdRVJmvBdt9R59jpKToq7lxVej7OQqzAhvAqM27
 K/KZ46xASDSuza/4USz4q1S/M62r2Bn/HZ9hfoZqwO1S5mTjFnbgSASh41c4DNR9EqUr2Zmjj
 j6po3xlD79q+jjdHXsDWrbPUnEwpESzCCh+J+cqnCzhTxq86isi3clKFFzKZAfXLnE8mB04Cl
 nyFjHvXOaSiQixb6D8OfLUmRLvgA60m43ibTE8+Ub/dtDCUW9jgUfvGT2bTVWfO0AYHeu81Cj
 NJ6Tj6rE9CxeNdDGbOYNY7NzM13iFvdvI5hEoKpVMoQrdqPQvvmQNeMdP/m6yYyGKSq2yDlpk
 SAJ31LUOKkN1EW8O8tpFyGGhdM0Sv0aVimcwnzU54JskWmyTQ14ExY7yGU6XcVhZUl+qgXeja
 MQIe0U80JLiSr/f/UGdnRKI05DY98nEqppaY0dvZTzDOV40BcOrY1WypBszs16spxuxJsOCa+
 1wIXkQrC+xIuNGmyKivLVbtEIvNDgP83Px5izwibrSZxpHOyuIYYPiTrm1P8WYQ2LfFDsiBYx
 Ph6LM1IggJvgZBIZO3qrDW9KWx8i3THPe5ZPnOdGL2SR3X37SbxhI2mTphWPSYuCoRummLFyc
 LzmAbldzGh4X/LoL8xe8IDaeEFrTxSaRISv3D7wnScq5hvvP0eAijkbkAubWhXLOVLStm839t
 Pfi4DChLMhnSVw2+KTZwZTCIr0OXTXXmB/HmGB6x+x8UOfZJ5gpCD97M5LExGrUz1RwXK5Avk
 nZC6TvU3SvMn7w=
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

So, use the array_size() helper to do the arithmetic instead of the
argument "count * size" in the vzalloc() function.

Also, take the opportunity to add a flexible array member of struct
vm_memory_region_op to the vm_memory_region_batch structure. And then,
change the code accordingly and use the struct_size() helper to do the
arithmetic instead of the argument "size + size * count" in the kzalloc
function.

This code was detected with the help of Coccinelle and audited and fixed
manually.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/virt/acrn/acrn_drv.h | 10 ++++++----
 drivers/virt/acrn/mm.c       |  9 ++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 1be54efa666c..fcc2e3e5232a 100644
=2D-- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -48,6 +48,7 @@ struct vm_memory_region_op {
  * @reserved:		Reserved.
  * @regions_num:	The number of vm_memory_region_op.
  * @regions_gpa:	Physical address of a vm_memory_region_op array.
+ * @regions_op:		Flexible array of vm_memory_region_op.
  *
  * HC_VM_SET_MEMORY_REGIONS uses this structure to manage EPT mappings of
  * multiple memory regions of a User VM. A &struct vm_memory_region_batch
@@ -55,10 +56,11 @@ struct vm_memory_region_op {
  * ACRN Hypervisor.
  */
 struct vm_memory_region_batch {
-	u16	vmid;
-	u16	reserved[3];
-	u32	regions_num;
-	u64	regions_gpa;
+	u16				vmid;
+	u16				reserved[3];
+	u32				regions_num;
+	u64				regions_gpa;
+	struct vm_memory_region_op	regions_op[];
 };

 /**
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index c4f2e15c8a2b..a881742cd48d 100644
=2D-- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -168,7 +168,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm=
_memmap *memmap)

 	/* Get the page number of the map region */
 	nr_pages =3D memmap->len >> PAGE_SHIFT;
-	pages =3D vzalloc(nr_pages * sizeof(struct page *));
+	pages =3D vzalloc(array_size(nr_pages, sizeof(struct page *)));
 	if (!pages)
 		return -ENOMEM;

@@ -220,16 +220,15 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_=
vm_memmap *memmap)
 	}

 	/* Prepare the vm_memory_region_batch */
-	regions_info =3D kzalloc(sizeof(*regions_info) +
-			       sizeof(*vm_region) * nr_regions,
-			       GFP_KERNEL);
+	regions_info =3D kzalloc(struct_size(regions_info, regions_op,
+					   nr_regions), GFP_KERNEL);
 	if (!regions_info) {
 		ret =3D -ENOMEM;
 		goto unmap_kernel_map;
 	}

 	/* Fill each vm_memory_region_op */
-	vm_region =3D (struct vm_memory_region_op *)(regions_info + 1);
+	vm_region =3D regions_info->regions_op;
 	regions_info->vmid =3D vm->vmid;
 	regions_info->regions_num =3D nr_regions;
 	regions_info->regions_gpa =3D virt_to_phys(vm_region);
=2D-
2.25.1

