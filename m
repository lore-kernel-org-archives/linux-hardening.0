Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA4C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 19 Sep 2021 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3AD9610A8
	for <linux-hardening@archiver.kernel.org>; Sun, 19 Sep 2021 09:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhISJrI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 19 Sep 2021 05:47:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:33063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234537AbhISJrH (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 19 Sep 2021 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632044692;
        bh=aBDCFlNyvlfJIyH2IMrQLyE2PqTuWdoxUKo2Qm78p8E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Hl0BQZhpSaZk1KGH7qplP3Lkye5LU25E2LvsYeULpeau6zFCzJjIyf4YCr4gD/QVF
         T8+H/5olMvZlgD08YJxcxCXoNk6YYodcKNW7soDOVLG14pMCYKLNFGTDcuzIBrMjW0
         etQQshbqQXjqTwGuuRaM0bMBDm3NwCdMI7nbR8CQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MMXUN-1m8Qqp1cqV-00JedI; Sun, 19 Sep 2021 11:44:52 +0200
From:   Len Baker <len.baker@gmx.com>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-afs@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Prefer struct_size over open coded arithmetic
Date:   Sun, 19 Sep 2021 11:44:32 +0200
Message-Id: <20210919094432.30510-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:atwHMRMtMSb4G+x9ytkpl64iqhfhlSU9FzgMUwkfrlCeQvi7lmx
 3LI0WfuSja+uW4DrJO+iEe3rymC0yv/OGWoXdpicHPD1Z4n1mFV/QlFiZmCWQte2ZP7Vwrh
 hJPEhgN1d1aLTrnBJ4rjJ0isi8wMT05xNLy9h+mj+xfnnKcWAJn6rrI/D7O8ZOpLE/hgAPA
 /rwrsPOvt/+tnfKLrbJXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jw9VNew2nUg=:4DZRDq0uojWSP6rF16MB6o
 138aPFhx5DTXyxufdek2mqo11X73k3NifxtwHlKs1hWLYMBlmvoQWhiKar71QkaXxVMxKd9z8
 kC24GEtoGq42H0tPlgAeICHs1g1pT3y0uJT9nzcXDIQGwy0og0dPSB0e6Ax1ys/oc6rXoIU3a
 Kb+Nhj8cKSQNl3TsiVHMP1P2H/3HqJVkSC54wq8xKVkKfwBwT5dTLWcPu9XaYVrvkRenVlmCa
 6gqxOxXGWHOzPi1y1AP8gV2mtPvaL6tOReBRHcLpgvYZN0ALwyPLbIEjfomO2LvMXRJCbtZE8
 tT6t0CksHaCxJzeRsrZi0ngikUjAfj9cZ3iVtpT770s3FzD98enzDO7afO4INnL635dmC5VS7
 7MhPzGwnpKCOTxLQvOwte4W8PWuIA3Nc9WPpWcl4udb5V/TvFZh0PX+MO3eAn7htsE0XZh7Qj
 jHcouTjDZEa6bB+j3CvsNxN5l+K5lJ2QHCUnbzrmgVGNLQKfZVH2H2ADHIHezX9ELB8F10h2h
 ym5JKMbIj/KRVC4F4XVM3g7L2UrME+jp3Y60GpJiswLzaZf/kzVqBnnnXYV1jKOZi7YWEgBsV
 kxOpm0AjYev3dKBAr/Ev+4psMD/F3E0G0n3fesAttmfTcSyfUkVt27x7PUHNR3vrjJq5E6ZxI
 y/Bmmsi/gQvpHx1TX5/ZwL7Kkmsq2aYBIMzkOj77n/ahmqyvlmgmVy5AAwsvsHjf1TwLx7It7
 RTv1/t7XWdffOYtDKDHGK+w4c9xrXRKtjgk6gdGOZwPtKXqBERMyDvba/MjW+/DwCcaYsVL3q
 fhi3YqlzB/rKOTnvYdWzhVcDiDOGZb2cO0hn3KH/jbiOcI/c3Up5bp/ebrIvm+wkspwiHBiQK
 Vml9KZoyZsCuJbPp6dichII73GyrIDOJOVf8sdVQcY3rHqpJDbuGGtpPgZQDSi8+Ce2XzGW3v
 ayfP8xu6fH2C8HwPc9K6IGbA1yVfsycFW27yPDY896OHRQBTIV76JU3GiyrbKXak8xpg6WOI8
 sKiT+eCIJNzxb8J23cb4cH8SB72UxuT4uoCG0X55g3NhIf09MAPr7Tyx7y4PtlqLRsPxPmH6G
 CeUc3mI/Fzw4K8=
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
argument "size + size * count" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 fs/afs/security.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/security.c b/fs/afs/security.c
index 3c7a8fc4f93f..7c6a63a30394 100644
=2D-- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -219,8 +219,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct =
key *key,
 	 * yet.
 	 */
 	size++;
-	new =3D kzalloc(sizeof(struct afs_permits) +
-		      sizeof(struct afs_permit) * size, GFP_NOFS);
+	new =3D kzalloc(struct_size(new, permits, size), GFP_NOFS);
 	if (!new)
 		goto out_put;

=2D-
2.25.1

