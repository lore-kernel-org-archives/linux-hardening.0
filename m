Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD72C433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 14:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C3360F14
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 14:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhIEOme (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:42:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:44691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEOmc (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 5 Sep 2021 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630852879;
        bh=/yNWBRvqjRvVJvu5VKkCkojXul/mjGRN/XfiECWSJkM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=I7++3TSRXjsTIoUO0U+ZzEorASnxONpYE0w7wjyv8St9DR0Dpgenh3Lz4sKgYrDkF
         QXOJ2bhZ3Zlmuln1CFrDnwKlwqXNnA43RRjP9frPBn4cSl8d5QABO0F0Vc/ew5ZiVm
         QpFmC2lH/i7zaS7Ya7sWB4UuHkJaFlhj+eoxUWe8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N79u8-1n1PAx1eMG-017V9e; Sun, 05 Sep 2021 16:41:19 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Nicolas Pitre <npitre@baylibre.com>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-i3c@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i3c/master/mipi-i3c-hci: Prefer struct_size over open coded arithmetic
Date:   Sun,  5 Sep 2021 16:40:54 +0200
Message-Id: <20210905144054.5124-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yc2GaUmluNaGyeUBD5O7eBSPVcxb2yxz/cdqXlCbWGPG4AzBvIx
 swPL75n8TCf1Dh4Mq7gXJOusgv/FFSN+3EHxwyRKa/mKG8lIb0zIjLAlXTl7Sg7A8rY/sF1
 Tiycvr8QMT51Y4Oi2f9ba8iEwhXcTholcGrPp1e0NzzU+SH3ik/uWYWdJMRQ1c+6E9enyYE
 TQ3HcftPZ06G6rFOLgoAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zYDDzlJ3NSw=:GnvIasji+IGndezvkoibuS
 4ZravIVL7n+M5ACFaaA5OCTuhuXNa/uOvA2IIRONr/29qzrwjZkaEmanGZ0piUuCiVShq3Pcj
 ryVsYGurW6Sw0hv6ze1K26F0vl3J6P8ZFRg9tNYJIn2x9bucitUm3aonIN2y915kKnfyzcntx
 c1O8+TjUC+7ZEGitpZkdWUvFUDpF54ID7fhFntoNDp5UkOwmLJhDVec7fSl3k9+i2LP9d+sIM
 k7q3Q66cWSV9SB64aQyCoCkKiXz2RJFlvxZ3fxJawbMrs+UMqJmQDRWlH2orb5n648YFFFxNP
 Ct1S5KaY88iGMQK1OfFM6gxIH+5pCw+AIq+zWl3WUkNFRWa1nUdAZA/+gvHc0NW5eyabMydCe
 xYvRX13+i1wEUtrHBuXgBjLKdXMdthzr3ohTzqr/xyC0Ww2N6mCH3SZaB0IEQZlnTLDm0LwD8
 /74yJLyh6PCAaTQsQ/X7qwbfPB9NNaz68F2oUnT6jkTFUrbO40Eg60QeG8RhtT96jm4PcdJky
 gPI4EQDYbGuZwUGENF8gp/uQaBZhUejhbrjiW7TRq81plTD3jG2xK2YoeBKT8+VYI1MFxzdEx
 zz5tVlACh7Ia6VFCB53wV2jAY/DwEB3P2Ks5nIwtG/ASGu4sIxuwZJ9TvmNCkucOAgcHtxjSv
 fh4J2lKxLDTO3VmreCP+R1DqfH7NjV95yRHFavmeqBGHWgW3J7PFylGti4JgVT0Y3JJJJ23GH
 auo9uc/dIl6Fqsd+afZrBk5uVhMnEzRewelyCQQ77IWcjPmOIPZkS7AvYA2D65lOQeNv4hWhs
 YNizgGcOQw7e+NhLF5XwhnaoMAUzLoYmxK9IAM04gCnHZtmDu8YbFp7kUX8oeFQERvPKhdUb9
 DnwOjrs0hmpmPRvu95rG07cWkiLEx/h52ouftJ0r7c4K6hciAhT5GkBL35TIwiNEfz8CX1qIf
 rdd6/HpPBtY/pq4GKEJTMJ2Grh0oRvjy0Z8m6iG7JTe/Go2V/uL+qLnNGS7FDLdxbj8ztmM2D
 yEVFEb9A7wHJ5VO6FRlbaFuJp7YEbegrhj4C7TzJa9vfFTat6CI8RKLKfSRw7JYYerxUSnfEl
 He02EeJDVlzNrrXVmOGDv4z2DwD5qwiKeEMF29NzZhxlSKGjJQe8vcXRw==
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
argument "size + count * size" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/i3c/master/mipi-i3c-hci/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mi=
pi-i3c-hci/dma.c
index af873a9be050..2990ac9eaade 100644
=2D-- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -223,7 +223,7 @@ static int hci_dma_init(struct i3c_hci *hci)
 	}
 	if (nr_rings > XFER_RINGS)
 		nr_rings =3D XFER_RINGS;
-	rings =3D kzalloc(sizeof(*rings) + nr_rings * sizeof(*rh), GFP_KERNEL);
+	rings =3D kzalloc(struct_size(rings, headers, nr_rings), GFP_KERNEL);
 	if (!rings)
 		return -ENOMEM;
 	hci->io_data =3D rings;
=2D-
2.25.1

