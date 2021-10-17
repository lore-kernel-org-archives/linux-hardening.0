Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F0C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Oct 2021 09:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F23260FDC
	for <linux-hardening@archiver.kernel.org>; Sun, 17 Oct 2021 09:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245202AbhJQJ7e (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 17 Oct 2021 05:59:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:45923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236079AbhJQJ7d (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 17 Oct 2021 05:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634464626;
        bh=GK27mjfavzFQQjBXkKn0RLCiDGh17zJ13VUyMZ39ERs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=g4QPrqgqY8bWgQhTWOHyALwiyqEIhfzf/HKIQKPTPGY6TZEFRMJrZBj0MbLPzX0uw
         UDK1QJfLuNmOw5NXdBONMR05OVNxh1AD8CDN6q+D3/TWDxg536mfm9gAb2vMU53Zzf
         MyMiyhqK27oR+DMbuFr3agQPgkvTv5twuWz87Rbk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MSc1B-1m94pM2rqD-00Szo6; Sun, 17 Oct 2021 11:57:05 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: prefer struct_size over open coded arithmetic
Date:   Sun, 17 Oct 2021 11:56:50 +0200
Message-Id: <20211017095650.3718-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:87l8oHXEfjCElo1TfalS+3I3QAENKqmFPDOlW7QVOffxRttv4nQ
 2AMPklv1f8oNxtJoCI1kESq9updTTNLaT8S8om5Xk+CPLW75asuvC0IENPAKV627O07UzWS
 JU0rMQ7aE5QwMkuA/Hrhj1oFv7UdgPM1pFkeoifDS3V5cmzqG+Z22u7ngNCUj7rElfftrgD
 Z7FYrBQVEwjaXW11HwaGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yuAiV954YSg=:cYURQWGEk30tKqGLBXHtIj
 xwzMpAgdJTjqcuvKEtY8b9OMK5hmvMS6vFB72geh5KDQmb6L2VSIby/8ELL5Hi8e2mWdKJdE7
 kN8c8d2q6zKTvzk4yu/LMKdCdkSnd/pfPcS9tNBu0Mc7GVSYjDJ5Pvj31a6skIkhuBb3ESdcy
 9WHIIcyk/AUgVIjIzTWstU8h7h4C4CdbbXwzRPOCOTHLWfnaedc0LnFJLA51dPyCpZcI+FKRz
 6otGxpVaEQ9HjA/gBUA1JAKuMahEDZzeOnurm7934tg+CL11vtjOKNr5+BRkSxBBhHhe0cdzC
 KRgrbbMzBPB8vX3r4fAh0W64z87bGB/PAKnX/krmDiMDyqIfRF+kAMtdjRa7uSBSfbE5c4FRx
 GE9up/5XUTPICti40Eu78nDoyPeUdBq70+A9n2aVbYrLDGo148Mqmnt5i86APP2Wg+LpIr71C
 E6cy9xBvB0240oWdoJTiupbH5+FTiC/D6Q7cIkM2FU0BBq1ZSQ2kqsPL7JUuGY9dTQdtiosKY
 guqOOEja0wSGQXwQ2tB8Oo1AEOi9M/pBdmW2D7/bIadpZ5YsQCEw89BkbP8P/Yc2RObG6zl10
 KgnqZi5A781t+XqWceb07dYGZAmYklqX3aez6cPLq4zgWlCKLTCGp8ZjYzkhbJUwEHdxj6ret
 Bc0VxgXIimfIWqpnmRSDbcFWhW2WPV5dtK4rt2WbaQBsqtVaZvXdZoZUgNSwRB9bc/vpYAcvL
 jGPwxATwLNezpK/ZZGSuFiCYWnVmAeOqbRa53b+d5eSMDYhvA+UdqRVQpaURea58WyhfmTjbS
 Wnbd0NYvhLxVRMkLwvlM5nUb7eErcedBzXWvNHgZRxzIHK42w6nbjxtKwtkFXN+nmxcrN5dvd
 tXByxa0ycZt1BG9R0o7ivvE5py/t1GiHlQFtZZJwYJQzRuj0SFV8Y689DN+9icZ7AQSEJHp5L
 4/7DhF6CNPKr2Z2PBiKPyXPUZIbQbCw0kCRn3bGdftJzbHqdF/cCypfYjGotYe+Jo8ghk+1HD
 rDov0d2PEF+4IxYO3xLlDlx6iW/WjFxoniNP8gu6S43Kjn5z7mj2Q0b9hPpDABsiRL9Vj3Qo6
 WPOhsZgyYVIzvs=
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

In this case this is not actually dynamic size: all the operands
involved in the calculation are constant values. However it is better to
refactor this anyway, just to keep the open-coded math idiom out of
code.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + count * size" in the kmalloc() function.

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

 drivers/nvme/target/admin-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-c=
md.c
index aa6d84d8848e..4aa71625c86a 100644
=2D-- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -278,8 +278,8 @@ static void nvmet_execute_get_log_page_ana(struct nvme=
t_req *req)
 	u16 status;

 	status =3D NVME_SC_INTERNAL;
-	desc =3D kmalloc(sizeof(struct nvme_ana_group_desc) +
-			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
+	desc =3D kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
+		       GFP_KERNEL);
 	if (!desc)
 		goto out;

=2D-
2.25.1

