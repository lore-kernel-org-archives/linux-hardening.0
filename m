Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6945FC433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 24 Oct 2021 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4513E60F9B
	for <linux-hardening@archiver.kernel.org>; Sun, 24 Oct 2021 17:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJXRc1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:32:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:38393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhJXRc0 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 24 Oct 2021 13:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635096586;
        bh=eJf292/lZFzvszJXQLPbd7P/v4bSpcZvX7PKS7XhsKs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ReDfyYeo49apVvB0odLLK/7xdF6Vcb/lxo8dsBEA7LGY8iQ2E28Dt8nodhXG9b/bu
         uQ63tAT8mf2St+ZvdWp3XXPmhCrv/Lp6ONk0Mw92ohYZ2ETOevVBrOtBlV6qNzhR7/
         2Isf8OwdSXP0kO2lS4bKy2Z3+CZ4M43ZMxetZOww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MLiCo-1mNASn3W7c-00HcSB; Sun, 24 Oct 2021 19:29:46 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: prefer flex_array_size and struct_size over open coded arithmetic
Date:   Sun, 24 Oct 2021 19:29:21 +0200
Message-Id: <20211024172921.4110-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nXvwuaFef6387OyRsR8ktRo9t1nVZlLvmGBWTQ0LCcys0NB7oV2
 qnV0JRZ0zDT9ZS1nL1szZ7q7Dp5lL4+sLpwFvqzVbc8OSxH9MYTlFLgcahgxkbEkAdLOVCA
 sWDRal7DUONvR0VCtwYsrFyLwxR62POK59fPUFFhlewU7yUypeps05E0uBtaY1H5eiv0zuy
 bZw5EgrNujNCCitXsqhbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6AN4P+IrtkM=:klp7il6T9/RgIJo2pQzhDA
 Mgsqnwf6pFMkXXq/+OwTSBeMu3TLa1ts+7cPFySclV6wz6S2qJcrhiUqrhiYiclkcOBoJKyaS
 YGLGm5jE5fnkIOWk9p2NQiB6xXHjSdP3UElHyKgTWJBHmYJh4GUeqnJEE3FavfJ5SLykWJHQm
 p8JgLexZZ1A5V29n7L0nC3JogfKw7A7OdpsMtzhu3ApZICS+6RxcVwMjkLSbLVjofK3j/g/xg
 /ZdBwkAjFaWHdXtw6B0+MzBRheYUPntEuTHXPdq2+WVLefp9HQklAGHDwwezcXRtcXzxY6Z98
 JhgNc8k2ECFviYpOKdBbfAcDXuHFjN6dFRKNlIFfoo2bwxOVaWdW4DVIZzY4l6d/59byxn0P7
 YlEDewFj4ZoRenpGC594bWZw+PlwhkchN9gdtbuyL6WoDhpItTM31IdbuH995dFFKuALnGHIu
 m0ha4eGaH1jsXuH5zlQW1touUPHgw9UKUN8c6nKVI9YlBZAuycHkZE7RvEUKgxPSfGY2r+uFZ
 cMEqXfG6vNnyDNWOAWeWkZ/l4YnZ1O/cQMHi2pJ0Eo6XzlL8Zvb0fFOhSX1YCbGV+j0WbdAoq
 sNCNCYkag4s/Vnu/glsUAQuvjviIaLv2i+Y+9nx7CukS404PJRIPnOHbz6DoK0xaDiiXuId0+
 g6pgq4vkxb783A7zM4ya3KT8JYt82vMh16eAib/9Wr2rqzaFg3txTjdfv7OJLejEx28rpYKJM
 /RByiebfAs0u+T3Di+K6gzGnputTx5VIXD3dGPXiTsZACqXHqgxhtThnhZt1Ek4iJFIoA3Yha
 VmRvDKw/PtM8bTDoo55rajW1w6vGHBViV5HKpecRlldYLFAHKJg2RbDIWXWeQGv1dXj427sPa
 D6oh1+8zaC7NHJu4E1guWow+6ZZ+kjUE+RntjzZMZBdS2skQa4ZKrnUOPdtB07//oZ8PWap/j
 tdENU/dCMV+8u7loj0+CVX9WHZvwJonhn79FHiLR/yvYwkjtw+vEg+RxS5A0g8GAaoOJK7585
 9EyNztWi0VTEyzdgmGLaIyXTWQeHiWJoxql4TJB1Ob5LlGXKHm8yCTg1sS5UQ0uvalBXrMYYH
 3U19DJxPaIkXMw=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In an effort to avoid open-coded arithmetic in the kernel [1], use the
flex_array_size() and struct_size() helpers instead of an open-coded
calculation.

[1] https://github.com/KSPP/linux/issues/160

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/nvme/host/multipath.c   | 2 +-
 drivers/nvme/target/admin-cmd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 954e84df6eb7..7f2071f2460c 100644
=2D-- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -562,7 +562,7 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, =
void *data,
 			return -EINVAL;

 		nr_nsids =3D le32_to_cpu(desc->nnsids);
-		nsid_buf_size =3D nr_nsids * sizeof(__le32);
+		nsid_buf_size =3D flex_array_size(desc, nsids, nr_nsids);

 		if (WARN_ON_ONCE(desc->grpid =3D=3D 0))
 			return -EINVAL;
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-c=
md.c
index 403de678fd06..6fb24746de06 100644
=2D-- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -264,7 +264,7 @@ static u32 nvmet_format_ana_group(struct nvmet_req *re=
q, u32 grpid,
 	desc->chgcnt =3D cpu_to_le64(nvmet_ana_chgcnt);
 	desc->state =3D req->port->ana_state[grpid];
 	memset(desc->rsvd17, 0, sizeof(desc->rsvd17));
-	return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);
+	return struct_size(desc, nsids, count);
 }

 static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
=2D-
2.25.1

