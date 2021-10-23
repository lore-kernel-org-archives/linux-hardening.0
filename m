Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76ADC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 23 Oct 2021 10:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C530A60FC4
	for <linux-hardening@archiver.kernel.org>; Sat, 23 Oct 2021 10:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhJWKSt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 23 Oct 2021 06:18:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:60789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhJWKSs (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 23 Oct 2021 06:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634984181;
        bh=oep7kxr70n/pnf3VV48pUPfgMoW9MV5wqciBsVib+dw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Dj/Cek8aC0QGqsa24y68Kj94T4yUQPmI4HOY2ZTpc2YiAdVv7VZVsed6uOJZw9l/n
         ve+Nwp2cvRxTX/EVWyyxNg/GdyF45yAMRVHc7sTSJueDtOCTkwAH0ImqwwcI7I1JY5
         d+cExm9SqFCCTsbY1iDrPPnnS6vH/gyXfIJf+TYQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Ml6m4-1n7lST0HUa-00lV9k; Sat, 23 Oct 2021 12:16:21 +0200
From:   Len Baker <len.baker@gmx.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Fei Li <fei1.li@intel.com>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2][next] virt: acrn: Prefer array_size and struct_size over open coded arithmetic
Date:   Sat, 23 Oct 2021 12:15:54 +0200
Message-Id: <20211023101554.4064-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8VE2EjEa9nY/CWKaFWJPCS7+H/zsiaXSooVyTAkJD2/Un8vDX7O
 Qk6bB7fjdBWSSlhnXaZnPDcPqx7Idb8lPIjGJV0ws6epfi57AWtWywOjLCydm6gO+5kb+9/
 lq2xts0o1sydcogyWD4QbuDfo2VjeglEBlbIdbyuKYvoF8RhGd/3y5y4aGuzHSyfoB5/jQr
 tyuMxKEvo6e6H0do77PJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4PuItPGevMM=:4TK7U2BwOnm01HJRXdywxG
 LSFaIk1W79A6gtk3bfKlm6o+/u3N2z3rSbasaY1RrgOIqfyivDkdAO2WZ1kfxH4qnZnTzlkbR
 r9oMSQbWT8ZY8nPBHdO7buwvYqS6ugoeNnMAszzB6tn6NWQLOc5HgJorAwuUt3CzxfTb9gobu
 ip5b9Yc6dXoP8ud2RyYOxVn013qRB4TAUiVPqmRp9j2Ydk4Yi48eBftYI3wNn2uK9vqYOZF+M
 +1+mH0DZE6Ra/QeE39DtOlmISw+TTOpBOTidUFO/1OpE+mANjTE9+uBF82k0kN4EZJl7reMFx
 gPh9OmUzrqdJntQdiAZzzC2S+2VCzFzIpIpfNEV8H9a/fJV3wT8KpZUsstC8nATqbs5F9AbfE
 eWAi/UJpN2ieFMBkT0QaA3G2lHGHfNmx7+Y7HuwBslFSj3mzZWDNsVsMPyGkK10Ych1Lk+NYI
 ZxI3zZT2IkwJ6eQLNCJb4B+dtWE2pInX5nwUVGKg7/C6+iFxVfCoC80ob6qNkWMJVls+avYoG
 6LGrpoIeh7+82DczwK63zoycGVygl4mc061nGuwxxhU2inVPHWgPi+FSsuh+VuHm6d17HxOQD
 8qJZCa+JPodIoSuQ0nnAm7mB7HP/ursglwkalNiffW2R+WcfBlIPG/DfVhxpap4KGI7SQNqnR
 FEqSWmAWGfnyls+zL90ycreqjbSZ9GGMvFP9Hvc2arcD36blI0qsa4UbMe5mpI2016tr1BFEm
 3QR4YETQ5ibqd9z5QJf2x8DFUOiFP9/ghC8uSJXMArsSPzVTTXkvF7rzbtsWzsHf3o3ZO/Pzl
 iVkObKfQVfpXkzmuCKZAzOXuqCHBnSr3MVZmFVkv+p6I8hBAOdQSVBv5yOyRuOkSwC+/ZOi3e
 eqAwKzFGTNCkTfPKSx74/YDwCdmCsgpFLUBf942roNlb0Vdlkls+Wr7AdCkRXFUYASgIjlMWf
 0IB3pu15RGYFzgmUl4x9ivFzX2Z77GHwaupQ0aas/Foqzh41BoNvvVUVib4eF6qldH16XmUQk
 RWdG2RkPcT8M0TjxM1bgkZUTrC1SVZs+KqOeLwpawPDj2R5mBEZ6aMskKzLSrSZDlcz1Z6Gnz
 w9jVJIX93V/rHs=
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

Hi Gustavo,

If there are no more comments in this version, can you take this patch?

Thanks,
Len

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

