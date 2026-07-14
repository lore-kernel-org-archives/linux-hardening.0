Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0034A1390
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042376; cv=none; b=KQT4hwRTNCgaurqK6oAfnWo09OjGMWrjA0fH8z4eiicw84+ZAIGT3voilx6h3YIL3fMBqduik2uCacxE2s0RJZFJ94v8l/E+e/oLoNsSbABWFDLgiHDA9BH+2403XC12sktHO5LisXW7vBmGAPjP2GawImw8U78kCDqoZEOkus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042376; c=relaxed/simple;
	bh=Xp9s8tZJA7nkiD5RUoHmjJ+DfJJCbZoJMCwWPFY+PwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=kLCGxA5AgaA6r8XcJE8IIyFSMlYvoPTQdC/TNQ6jqZfRwQB3Tpgv9pWiMcE/qv96unWcRVRWy5Z8C7TEiLkv6WDrnh2VbhoIDh3ZLWJY+qwIbsoMFn+S/Qhp0eHt/NfAi0jWpK6WYdg4Fsfzd3VdFqCcDYRNgcg64YI6/XhrnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYUniIUo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYUniIUo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784042374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=blE1l/fSbP/6balVpCO8VC1IyJ+7b4JfQ59eHK8tgiI=;
	b=PYUniIUo0cyBSmjSuKjxzUOWXI7RsLsv0L5ImOfDA00JpTnmsVD1aJazR8yylVp0CYdL8s
	nkPg7OkfGjhIjrU22SUWksJWxZnhopMoBpe2RyWrzSzN76tHsSDmab6lGEgg7vsLdSP1Rn
	TYw8b1A2BVNraqQCJU7tMvvSuLveXhM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-J1pnN-jMN0m2bFzmnWpDTw-1; Tue,
 14 Jul 2026 11:18:23 -0400
X-MC-Unique: J1pnN-jMN0m2bFzmnWpDTw-1
X-Mimecast-MFC-AGG-ID: J1pnN-jMN0m2bFzmnWpDTw_1784042301
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99E451802669;
	Tue, 14 Jul 2026 15:18:21 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.17.152])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9078D195604B;
	Tue, 14 Jul 2026 15:18:19 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	Jesse Taube <mr.bossman075@gmail.com>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [RFC PATCH] overflow: Add DECLARE_SIZED_FLEX() helper family
Date: Tue, 14 Jul 2026 11:18:18 -0400
Message-ID: <20260714151818.538869-1-jtaubepe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: kzxNpuKVCZxEqCylWyu0Bp7w-mTSl97TOQZEsft097w_1784042301
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add new DECLARE_SIZED_FLEX() helper to set the default size of a
flexible-array member. The code is identical to the declaration in
__DEFINE_FLEX() which has also been changed to use DECLARE_SIZED_FLEX().

Add DECLARE_COUNTED_FLEX_ARRAY() helper which is a variant of
DECLARE_FLEX_ARRAY() with a counted-by attribute.

Also add default sized variants of
DECLARE_FLEX_ARRAY(), DECLARE_SIZED_FLEX(), and
DECLARE_COUNTED_FLEX_ARRAY(), DECLARE_COUNTED_SIZED_FLEX().

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
 include/linux/overflow.h | 58 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index a8cb6319b4fb..a3384cae49e5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -464,6 +464,59 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
  */
 #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
 
+/**
+ * __DECLARE_SIZED_FLEX() - helper macro for DECLARE_SIZED_FLEX() family.
+ * Allows for easily declaring a structure with a trailing flexible array member
+ * to have a specific size.
+ *
+ * @obj: object to be given a specific size
+ * @name: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ */
+#define __DECLARE_SIZED_FLEX(obj, name, count)	\
+	_Static_assert(__builtin_constant_p(count),		\
+		       "default sized flex array members require compile-time const count");	\
+	union {							\
+		u8 bytes[struct_size_t(obj, name, count)];	\
+		obj;						\
+	}
+
+/**
+ * DECLARE_COUNTED_FLEX_ARRAY() - Declare a counted flexible array
+ *
+ * @type: Type name.
+ * @name: Name of the array member.
+ * @counter: Name of the __counted_by member.
+ */
+#define DECLARE_COUNTED_FLEX_ARRAY(type, name, counter)\
+	struct { \
+		size_t counter; \
+		type name[] __counted_by(counter); \
+	}
+
+/**
+ * DECLARE_SIZED_FLEX() - Declare a structure with a trailing flexible array
+ * member with a default size.
+ *
+ * @type: Type name.
+ * @name: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ */
+#define DECLARE_SIZED_FLEX(type, name, count)	\
+	__DECLARE_SIZED_FLEX(type name[], name, count)
+
+/**
+ * DECLARE_COUNTED_SIZED_FLEX() - Declare a structure with a trailing flexible
+ * array member counted by count, with a default size.
+ *
+ * @type: Type name.
+ * @name: Name of the array member.
+ * @counter: Name of the __counted_by member.
+ * @count: Number of elements in the array; must be compile-time const.
+ */
+#define DECLARE_COUNTED_SIZED_FLEX(type, name, counter, count)	\
+	__DECLARE_SIZED_FLEX(DECLARE_COUNTED_FLEX_ARRAY(type, name, counter), name, count)
+
 /**
  * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
  * Enables caller macro to pass arbitrary trailing expressions
@@ -477,10 +530,7 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
 #define __DEFINE_FLEX(type, name, member, count, trailer...)			\
 	_Static_assert(__builtin_constant_p(count),				\
 		       "onstack flex array members require compile-time const count"); \
-	union {									\
-		u8 bytes[struct_size_t(type, member, count)];			\
-		type obj;							\
-	} name##_u trailer;							\
+	__DECLARE_SIZED_FLEX(type obj, member, count) name##_u trailer;		\
 	type *name = (type *)&name##_u
 
 /**
-- 
2.54.0

