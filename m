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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA61C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 19 Sep 2021 11:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A2D61205
	for <linux-hardening@archiver.kernel.org>; Sun, 19 Sep 2021 11:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhISLLM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 19 Sep 2021 07:11:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:48799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhISLLM (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 19 Sep 2021 07:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632049779;
        bh=Sa7rgxAm33/0PVzQRFTAg4lg8sGWxqVYEZg9l8Ht83k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=OUIQ7VczJP+TFIvXwyVP+rJQlMwRQ5JfHu3I85MJDShhNHtF86vfkeGCLShSooQPO
         e85dHIgZK5vTydhmIBkzmVamLQvoKv4YqDOzvEjSBnpkDxUK5Zwl23Yncov7QlkyqY
         9OaVj9K84F/giD8+s/Hknru2qRoZ2FyeM/lQzgtc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MfHEJ-1n6zsW1I9j-00gnYb; Sun, 19 Sep 2021 13:09:39 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] assoc_array: Avoid open coded arithmetic in allocator arguments
Date:   Sun, 19 Sep 2021 13:09:13 +0200
Message-Id: <20210919110913.39386-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XmKVjq3VBHYQXBZnggLIGOm6ADkiRMDNlb/8F/rnGh6woW38yOh
 hhNHR9QQ0JVV4QPUXbnzI8QpBZblv7qlRAi0Nbz3hlnFR1Khm1uNV35Ha+624mqvxWJa/3t
 /UKzw9c32OcDoINdw6+WAh0gWBrd7yeXnlOCCHel+fZNPWGx4lpaVLEA8DyPex+LAxJ6Fn0
 5SPAeAoEUEbahR0rkbkmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpyW4F228S0=:jRMkSESW2YDfG90r1w72hM
 TNbJjmlRneAOA/9+IdwW40RZoIPkPytIsi1yE0xZcWDCVbb3u5OyAWQvW6pCzwF9/LhBH0oLz
 HzDAMivgfF7n6KFyZT6e5zSI6ajsN5GrND1D6BJidi2qxcsBLJHAJR+2B9SSH0QFovMFp7+hH
 Xp5ePIP/7/qsjTqjLJQ+usYet2ykAJDCy9qiUpRrs/TisnarbD88Ic5jp6FYXqBHICLHTMQEE
 6uMhcHj5KQC4veJIdpFpCvJgNIu8rpBP3mhZfaNZUk5o/+j/oo+luXK/buDcLKMV6m7VewOrf
 1UBfTE+6Cdf2UdMoFh4qdwVt01X6Yx580H59/gK8DyjHW8j6ZIanfwNRqcYIfFxomel+esM4M
 72Nco1DmpQc1JEFtOf41EtwrSe9ppEfewvCh74WpZqBTQQa5oODPRtB7SkfQ2KcnzcFEuHKel
 SlyjNNVbearHCxPyHpWeDxctooF2NHNnKV1OkU4ikFYFy9R4r0LDiU1qXRvghx4TjEJF1a5iI
 ILQ4vZ5lPVOUoqcqOnhitiQ172Ae2azrpnRE+B8amucOEMVEWAMZlevI6uLw2188Z2wk7QtYb
 ktA5OoII7pEZ6HWdyo604qMKZ0jvB64lZ+eyNWbZ/Ubdz7OArEbqHwC3le9MhjKa2Ddez06uE
 7CHZHDaQ0rIumoYnqWGvZ3xlJNMIQ2/BFhCSpfqB/C2rLf+bK8yu3l+JhQmr8QGYxRK40UGhn
 lSL4gIpN5aFP90EUfcPbaL0JvM1bsiP6OpJm5NntQ41uerisiOlNk+aGCEVFatpTK/JehiMEv
 NxR341oTeLwxYALpp20H1c7QGO91AQpHnrZHnAes7EeEuL8JKM8vUx5U06vGlZeJ9ALYkKW9i
 tZocW44lZx/EUKxXAzvXS52Gf/YlPCJn9FXFZJoTsA1jxbH57oSPZ3q+YK9dNFdS1GQ+46d6d
 G1C/3xXtTIgUlxarNj8qvjWt0LCDjraDkOryoYKa2jU1OMP09UonBQP7NKfRsfIZN0csQNPBL
 G13wQ+7hxNd9pcs19kPaOLLMoQCzpahhaubJ5RSXBffIh6HzbxBIBhHP/zSakA+E6ahs6tO/B
 dm06W8OGJxkg2c=
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
argument "size + count * size" in the kmalloc() and kzalloc() functions.

Also, take the opportunity to refactor the memcpy() calls to use the
struct_size() and flex_array_size() helpers.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 lib/assoc_array.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 04c98799c3ba..079c72e26493 100644
=2D-- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -741,8 +741,7 @@ static bool assoc_array_insert_into_terminal_node(stru=
ct assoc_array_edit *edit,
 	keylen =3D round_up(diff, ASSOC_ARRAY_KEY_CHUNK_SIZE);
 	keylen >>=3D ASSOC_ARRAY_KEY_CHUNK_SHIFT;

-	new_s0 =3D kzalloc(sizeof(struct assoc_array_shortcut) +
-			 keylen * sizeof(unsigned long), GFP_KERNEL);
+	new_s0 =3D kzalloc(struct_size(new_s0, index_key, keylen), GFP_KERNEL);
 	if (!new_s0)
 		return false;
 	edit->new_meta[2] =3D assoc_array_shortcut_to_ptr(new_s0);
@@ -849,8 +848,8 @@ static bool assoc_array_insert_mid_shortcut(struct ass=
oc_array_edit *edit,
 		keylen =3D round_up(diff, ASSOC_ARRAY_KEY_CHUNK_SIZE);
 		keylen >>=3D ASSOC_ARRAY_KEY_CHUNK_SHIFT;

-		new_s0 =3D kzalloc(sizeof(struct assoc_array_shortcut) +
-				 keylen * sizeof(unsigned long), GFP_KERNEL);
+		new_s0 =3D kzalloc(struct_size(new_s0, index_key, keylen),
+				 GFP_KERNEL);
 		if (!new_s0)
 			return false;
 		edit->new_meta[1] =3D assoc_array_shortcut_to_ptr(new_s0);
@@ -864,7 +863,7 @@ static bool assoc_array_insert_mid_shortcut(struct ass=
oc_array_edit *edit,
 		new_n0->parent_slot =3D 0;

 		memcpy(new_s0->index_key, shortcut->index_key,
-		       keylen * sizeof(unsigned long));
+		       flex_array_size(new_s0, index_key, keylen));

 		blank =3D ULONG_MAX << (diff & ASSOC_ARRAY_KEY_CHUNK_MASK);
 		pr_devel("blank off [%zu] %d: %lx\n", keylen - 1, diff, blank);
@@ -899,8 +898,8 @@ static bool assoc_array_insert_mid_shortcut(struct ass=
oc_array_edit *edit,
 		keylen =3D round_up(shortcut->skip_to_level, ASSOC_ARRAY_KEY_CHUNK_SIZE=
);
 		keylen >>=3D ASSOC_ARRAY_KEY_CHUNK_SHIFT;

-		new_s1 =3D kzalloc(sizeof(struct assoc_array_shortcut) +
-				 keylen * sizeof(unsigned long), GFP_KERNEL);
+		new_s1 =3D kzalloc(struct_size(new_s1, index_key, keylen),
+				 GFP_KERNEL);
 		if (!new_s1)
 			return false;
 		edit->new_meta[2] =3D assoc_array_shortcut_to_ptr(new_s1);
@@ -913,7 +912,7 @@ static bool assoc_array_insert_mid_shortcut(struct ass=
oc_array_edit *edit,
 		new_n0->slots[sc_slot] =3D assoc_array_shortcut_to_ptr(new_s1);

 		memcpy(new_s1->index_key, shortcut->index_key,
-		       keylen * sizeof(unsigned long));
+		       flex_array_size(new_s1, index_key, keylen));

 		edit->set[1].ptr =3D &side->back_pointer;
 		edit->set[1].to =3D assoc_array_shortcut_to_ptr(new_s1);
@@ -1490,13 +1489,12 @@ int assoc_array_gc(struct assoc_array *array,
 		shortcut =3D assoc_array_ptr_to_shortcut(cursor);
 		keylen =3D round_up(shortcut->skip_to_level, ASSOC_ARRAY_KEY_CHUNK_SIZE=
);
 		keylen >>=3D ASSOC_ARRAY_KEY_CHUNK_SHIFT;
-		new_s =3D kmalloc(sizeof(struct assoc_array_shortcut) +
-				keylen * sizeof(unsigned long), GFP_KERNEL);
+		new_s =3D kmalloc(struct_size(new_s, index_key, keylen),
+				GFP_KERNEL);
 		if (!new_s)
 			goto enomem;
 		pr_devel("dup shortcut %p -> %p\n", shortcut, new_s);
-		memcpy(new_s, shortcut, (sizeof(struct assoc_array_shortcut) +
-					 keylen * sizeof(unsigned long)));
+		memcpy(new_s, shortcut, struct_size(new_s, index_key, keylen));
 		new_s->back_pointer =3D new_parent;
 		new_s->parent_slot =3D shortcut->parent_slot;
 		*new_ptr_pp =3D new_parent =3D assoc_array_shortcut_to_ptr(new_s);
=2D-
2.25.1

