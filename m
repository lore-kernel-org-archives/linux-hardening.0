Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC48C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Oct 2021 17:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37ACB610A0
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Oct 2021 17:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhJ2Rau (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:30:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:41847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhJ2Rat (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Oct 2021 13:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635528492;
        bh=wA5vZ50jUUEtjv2u4EvKaku5j2wbU9DZtBi8KMuY5GQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QRkMLdyo1G7kEFmxR9d37Ho97vGOUTs+5HbBLZos9xmg8x4zQgvQm0EV2i8DG3BMz
         dOO96c5Jv2xf579y5K2q793K4HvKIHGO4yHHfl8LNgj2W0AhUoVazagKOMPlhRLH+9
         JO5DBeM5w/3MjMk+4HStzWx2Hr2ft9ozp7BKxpq0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MysVs-1muTtO0TDu-00vsvT; Fri, 29 Oct 2021 19:28:12 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Fei Li <fei1.li@intel.com>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3][next] virt: acrn: Prefer array_size and struct_size over open coded arithmetic
Date:   Fri, 29 Oct 2021 19:27:46 +0200
Message-Id: <20211029172746.7563-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FBYfBYOa9vEdjzrjSk0uTej9Gc4j7RFVce62dXXlYz3Q8AWd/8K
 etMArQnf7ZQoWUxlYmGX8hD9hFOaz5NQyvW1FtjtWIr13+1Dg+ZCIn5t0k+BBBTo0ZRARjs
 RtaE8oO7L8DinZaZWOQ1eUkDZrgR9sdWtaQ+SCQW7H03J7p8MZ4rBoR7YYMpZQqwNkooDI9
 Wa+DGVqlzYpj4CZ3oSCkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WasQtGQS9lY=:MeN2bjFhN/1OHmz5PnKj2d
 Wfu6l6LWonWkl5XsSIsmrkXC+pq1wiatw4EyKQSyQlRBloSL79qdNHj3Gmm0B1/MjCxA/y5XX
 Ygh/uVkiA3rtQDMYRt0YJG0wpTdC31kT0GJE1i3EDaoRMuLYwhqdEhJy7djkAF+U3Cl8+w0OC
 b+oYX5jLTUfxtIQsllNg8u2h/VRl2XFuF3rmPnpbE5Ld3956i0WzeNKzdgvqxxEsGwNG2WieC
 GSHwbnsBErG9JqySZOerGkfs/MQ2xGBpilcojv2mf9NjzKaA13r2+i6qUkGTFdMk+B/NdGb88
 gHxwyFOoavyF8DcGBKJM11NzEEREQbRf4WFHVTgUe9sfz/hMFKHb4HaDUwVAINpiiZ/sxy8g6
 73jimmbrceJFOSMCcE0EJXvQ0px38ofjSKdUgJ9OqKlPIHeClzR6z9SQQACHjSvKSWeBn3FGw
 sFmlHqzPdmpGXb5UhpLfnlp0Z1xt3WQv3a0wdvgFvKLO2mXruW4w15ADT8GN2UGQW++K9p49M
 Ac43/+kDr45WBO3vCZ2RmUgl2uufnv9MyLF0WI2TPJlOk3p4wFyIop0cvpftBCezsaMtlwI0b
 WaGhTrkNrfCaa/dUsit7snlK2iNprAG1naThK+y33mcT45Z9pJ2NBQspYpr/+/KHnJEQRwWSv
 UR3YdXilKHv+K6pH9GpNMZ61W1rNfMltOlKpJjhDa2SUISExs0jsIbM4/b9F+bnAZLAUBPs9C
 ZzzJNtwYbs1MWwTkozRmD8ew7gI4rt3aMiAui8GDIikRjnazwJOvriAY7nWRKezbKNJzISlxE
 1z+mvOE96yH54DV1qrHTc5u4dEjZ9JvFEr3v/+TferLPh1x+s7kTN/lwOKo/lu1XyyUyLgg2N
 YpjxB9bCsuZkYkxl+JwI7k6HzS1EjR+GWYH6ZtLVWYDuE3+gE8aIdke3XkoY/fwb5b/KOsC0/
 OqGdGHagoah598TAdKtPXrlBHEV5Lkk9PV1XPMK87B/cBVIlVkQnnN98AwxBFKEJ3M3DAB+G3
 Fsf6bETqTi9NO7xS3tuDjdNKQBh8btcuTwK2UXM1OmTUoC8uOvvYdxJy0aK1QdCOywPexlbvM
 5uCDDYcE6lZJn8=
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

Acked-by: Fei Li <fei1.li@intel.com>
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Changelog v1 -> v2
- Fix the typo "syze -> size" in the subject (Kees Cook).
- Reduce the number of tabs in the definition of the structure
  vm_memory_region_batch (Fei Li).
- Add the "Acked-by" tag.

Changelog v2 -> v3
- Use the variable instead of the struct name in the sizeof()
  function used in the array_size() function.

 drivers/virt/acrn/acrn_drv.h | 10 ++++++----
 drivers/virt/acrn/mm.c       |  9 ++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 1be54efa666c..5663c17ad37c 100644
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
+	u16			   vmid;
+	u16			   reserved[3];
+	u32			   regions_num;
+	u64			   regions_gpa;
+	struct vm_memory_region_op regions_op[];
 };

 /**
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index c4f2e15c8a2b..ba241a24c48e 100644
=2D-- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -168,7 +168,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm=
_memmap *memmap)

 	/* Get the page number of the map region */
 	nr_pages =3D memmap->len >> PAGE_SHIFT;
-	pages =3D vzalloc(nr_pages * sizeof(struct page *));
+	pages =3D vzalloc(array_size(nr_pages, sizeof(*pages)));
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

