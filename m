Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5240EB9C;
	Mon, 14 Sep 2026 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425472; cv=none; b=GWItlBwyyRdYd7P+zSMY6TQvbpB0VA00SwQ62q00w5g/xPZdlVHzgSUhSn+s7EJdrb8D09wDCBg1UKHXx3cyxZV9FJigKGSd93HvJAQMC/D49hHW5tVYTBJrYAz6BkXz20JOsYqFJ3lyiKogqxE21Gzuu6SIQxzujNsJLm28v04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425472; c=relaxed/simple;
	bh=5Y3Qv8aSWtG1ldbvwnoLA2PLP4W7OW/PZbwFVfjYd74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cOnlHNb06GYa72u3C+2hHOv+p69krFzr/rZqZuUsyLTMkE6fOMe3Y2QK37t++avwko8VyFKpRHXqSBbIu7+Rysdk+gI2oy6RP4WcvbrVj8NyiDtYVmjVtcXaRDWArQBuY97jcAlNQFxxvdtUqRzFRDiu1Bo5dHhHt+XHpXQ1qSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwR7Z/+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwR7Z/+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C9C1F000FF;
	Mon, 14 Sep 2026 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789425470;
	bh=oFoR9qQIdwt3+vZZkEYKmSOPISctBhe05eYTvaM9nRc=;
	h=From:To:Cc:Subject:Date;
	b=nwR7Z/+brNyjYCiKk5tA1AWiP71C0jjpBP4OUjVWMIY8zC1DHCgYLPJPQ9k2fjm7e
	 afcKlGR/P40QmBQ+JB7za6HgqcNZHHubYdNqQFi4TGbannqx9lfyQVk09FvLqZGbRQ
	 W6WChnoOdw1GEJvDm+7Bx6Xi00/XgC5+wLRJAfBhqfc91zhPWbmGn9Jm4Rxqlne9WI
	 MNFVsUOjTcQQsdgAnQnprRRJDjY+M0+2nJhFLEWmnCGXZ2zdDeTUN3FjRlt0XKL1+z
	 U/ya0cBc+R6oNUiWgxI7Qw5I6/3TtkNxc1Hnac4DHOGjLvtEaI/+ZqFDxCOBp2Oau0
	 dB68PFECv9lcg==
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] coccinelle: kmalloc_obj: Convert multi-byte integral allocations
Date: Mon, 14 Sep 2026 15:37:49 -0700
Message-Id: <20260914223748.i.971-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11778; i=kees@kernel.org; h=from:subject:message-id; bh=5Y3Qv8aSWtG1ldbvwnoLA2PLP4W7OW/PZbwFVfjYd74=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkrym2SOLM6ZnZl3HqwQu5f07ID4jlbZeO+8tTtCNURf ZCZtN+oo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLHCxgZlm37xp/3hjtz2gfP A8vFhaM4Fp5mzvu5VDeRKaBAtSTSg5Hhye/S/2KHkpoCFl090HzIjz/C1mlW6tbfquc86rfU6Ac xAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Currently the kmalloc_obj conversion rules leave alone every allocation
sized to an integral type, or assigned to a pointer to one, so that byte
buffers keep being allocated with a byte count. That also leaves alone
arrays of multi-byte integers, such as

	vals = kcalloc(n, sizeof(u32), GFP_KERNEL);

which count objects like any other array. At the same time the signed
types (s8 through s64 and their variants) were not in the list at all.
But these multi-byte types are better handled through the full
kmalloc_obj-style allocation, as they are, in fact, typed and aren't
just a byte string, so they would benefit from type checking.

Split INTEGRAL into BYTE_TYPES and MULTIBYTE_TYPES:

 - Allocations sized by a byte type or a string literal, or assigned to
   a pointer to a byte type, are still left alone.
 - Allocations sized by a multi-byte type are converted when they are
   assigned to a pointer, or a pointer to const, of that same type.
   Other allocations sized by a multi-byte type are left alone, as their
   target may be a pointer to an array.
 - Allocations of other types assigned to a pointer to a multi-byte type
   are still left alone.
 - Arrays of pointers to integral types sized by type, such as
   sizeof(char *), are still left alone, now including the signed
   types, as their target may be a pointer to an array of pointers, like
   "const char *(*fmts)[]". Sized as sizeof(*target), they are converted
   like any other array.

List the signed types and the other spellings of the standard integer
types (short int, unsigned, long long int, and so on), so that a
declaration and a sizeof() that spell the same type differently still
match.

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: <cocci@inria.fr>
---
 scripts/coccinelle/api/kmalloc_objs.cocci | 161 +++++++++++++++++-----
 1 file changed, 129 insertions(+), 32 deletions(-)

diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
index e9a415b7b6f4..0a98ddf03eca 100644
--- a/scripts/coccinelle/api/kmalloc_objs.cocci
+++ b/scripts/coccinelle/api/kmalloc_objs.cocci
@@ -24,27 +24,57 @@ def alloc_array(name):
 		print(f"Unknown transform for {name}", file=sys.stderr)
 	return func
 
-// This excludes anything that is assigning to or from integral types or
-// string literals. Everything else gets the sizeof() extracted for the
-// kmalloc_obj() type/var argument. sizeof(void *) is also excluded because
-// it will need case-by-case double-checking to make sure the right type is
+// Allocations sized by a byte-sized type (BYTE_TYPES) or a string literal,
+// and allocations assigned to a pointer to a byte-sized type, are byte
+// buffers and are left alone. sizeof(void *) is also excluded because it
+// will need case-by-case double-checking to make sure the right type is
 // being assigned.
+//
+// Allocations sized by a multi-byte integral type (MULTIBYTE_TYPES) are
+// converted when they are assigned to a pointer to that same type.
+// Otherwise they are left alone: the target may be a pointer to an array
+// of that type, such as "s16 (*pairs)[2]", for which the converted
+// allocation would have the wrong pointer type. For the same reason,
+// arrays of pointers to integral types sized as sizeof(char *) and the
+// like are left alone. Allocations of other types assigned to a pointer to
+// a multi-byte integral type are left alone too.
+//
+// Everything else gets the sizeof() extracted for the kmalloc_obj()
+// type/var argument.
+//
+// The first matching alternative below wins, so the exclusions must come
+// before the more general conversions.
 @direct depends on patch && !(file in "tools") && !(file in "samples")@
 typedef u8, u16, u32, u64;
 typedef __u8, __u16, __u32, __u64;
 typedef uint8_t, uint16_t, uint32_t, uint64_t;
+typedef s8, s16, s32, s64;
+typedef __s8, __s16, __s32, __s64;
+typedef int8_t, int16_t, int32_t, int64_t;
 typedef uchar, ushort, uint, ulong;
 typedef __le16, __le32, __le64;
 typedef __be16, __be32, __be64;
 typedef wchar_t;
-type INTEGRAL = {u8,__u8,uint8_t,char,unsigned char,uchar,wchar_t,
-		 u16,__u16,uint16_t,unsigned short,ushort,
-		 u32,__u32,uint32_t,unsigned int,uint,
-		 u64,__u64,uint64_t,unsigned long,ulong,
-		 __le16,__le32,__le64,__be16,__be32,__be64};
+type BYTE_TYPES = {char,signed char,unsigned char,uchar,
+		   u8,__u8,uint8_t,s8,__s8,int8_t};
+type MULTIBYTE_TYPES = {short,short int,signed short,signed short int,
+			unsigned short,unsigned short int,ushort,
+			int,signed,signed int,unsigned,unsigned int,uint,
+			long,long int,signed long,signed long int,
+			unsigned long,unsigned long int,ulong,
+			long long,long long int,
+			signed long long,signed long long int,
+			unsigned long long,unsigned long long int,
+			u16,__u16,uint16_t,s16,__s16,int16_t,
+			u32,__u32,uint32_t,s32,__s32,int32_t,
+			u64,__u64,uint64_t,s64,__s64,int64_t,
+			__le16,__le32,__le64,__be16,__be32,__be64,
+			wchar_t};
 char [] STRING;
-INTEGRAL *BYTES;
-INTEGRAL **BYTES_PTRS;
+BYTE_TYPES *BYTES;
+MULTIBYTE_TYPES *MULTIBYTES;
+const MULTIBYTE_TYPES *CONST_MULTIBYTES;
+MULTIBYTE_TYPES MULTIBYTE;
 type TYPE;
 expression VAR;
 expression GFP;
@@ -59,66 +89,133 @@ fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARR
 @@
 
 (
+// Convert a single object sized by its target: p = kmalloc(sizeof(*p), gfp)
 -	VAR = ALLOC((sizeof(*VAR)), GFP)
 +	VAR = ALLOC_OBJ(*VAR, GFP)
 |
-	ALLOC((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+// Exclude byte buffers and integral pointers: kmalloc(sizeof(u8), gfp),
+//   kmalloc(sizeof("str"), gfp), kmalloc(sizeof(char *), gfp)
+	ALLOC((\(sizeof(STRING)\|sizeof(BYTE_TYPES)\|
+		sizeof(BYTE_TYPES *)\|sizeof(MULTIBYTE_TYPES *)\)), GFP)
 |
-	BYTES = ALLOC((sizeof(E)), GFP)
+// Exclude anything assigned to a byte pointer:
+//   u8 *buf = kmalloc(sizeof(*hdr), gfp)
+	BYTES = ALLOC((\(sizeof(E)\|sizeof(TYPE)\)), GFP)
 |
-	BYTES = ALLOC((sizeof(TYPE)), GFP)
+// Convert a multi-byte type to a pointer to it:
+//   u32 *p = kmalloc(sizeof(u32), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC((sizeof(MULTIBYTE_TYPES)), GFP)
++		ALLOC_OBJ(MULTIBYTE_TYPES, GFP)
 |
-	BYTES_PTRS = ALLOC((sizeof(E)), GFP)
+// Same by expression: u32 *p = kmalloc(sizeof(p[0]), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC((sizeof(MULTIBYTE)), GFP)
++		ALLOC_OBJ(MULTIBYTE, GFP)
 |
-	BYTES_PTRS = ALLOC((sizeof(TYPE)), GFP)
+// Exclude other multi-byte sizes, e.g. to pointers to arrays: s16 (*p)[2] = ...
+	ALLOC((\(sizeof(MULTIBYTE_TYPES)\|sizeof(MULTIBYTE)\)), GFP)
 |
+// Exclude anything else assigned to a multi-byte pointer:
+//   u32 *p = kmalloc(sizeof(*hdr), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) = ALLOC((\(sizeof(E)\|sizeof(TYPE)\)), GFP)
+|
+// Exclude void pointers, to be checked by hand: kmalloc(sizeof(void *), gfp)
 	ALLOC((sizeof(void *)), GFP)
 |
+// Convert any other expression: p = kmalloc(sizeof(s->item), gfp)
 -	ALLOC((sizeof(E)), GFP)
 +	ALLOC_OBJ(E, GFP)
 |
+// Convert any other type: p = kmalloc(sizeof(struct item), gfp)
 -	ALLOC((sizeof(TYPE)), GFP)
 +	ALLOC_OBJ(TYPE, GFP)
 |
-	ALLOC_ARRAY(COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
-|
-	BYTES = ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
-|
-	BYTES = ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
-|
-	BYTES_PTRS = ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
+// The same, for arrays allocated as (count, size):
+// Exclude byte buffers and integral pointers: kcalloc(n, sizeof(u8), gfp),
+//   kcalloc(n, sizeof(char *), gfp)
+	ALLOC_ARRAY(COUNT, (\(sizeof(STRING)\|sizeof(BYTE_TYPES)\|
+			    sizeof(BYTE_TYPES *)\|sizeof(MULTIBYTE_TYPES *)\)), GFP)
 |
-	BYTES_PTRS = ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
+// Exclude arrays assigned to a byte pointer:
+//   u8 *buf = kcalloc(n, sizeof(*hdr), gfp)
+	BYTES = ALLOC_ARRAY(COUNT, (\(sizeof(E)\|sizeof(TYPE)\)), GFP)
 |
-	ALLOC_ARRAY((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), COUNT, GFP)
+// Convert a multi-byte array to a pointer to it:
+//   u32 *p = kcalloc(n, sizeof(u32), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC_ARRAY(COUNT, (sizeof(MULTIBYTE_TYPES)), GFP)
++		ALLOC_OBJS(MULTIBYTE_TYPES, COUNT, GFP)
 |
-	BYTES = ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
+// Same by expression: u32 *p = kcalloc(n, sizeof(*p), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC_ARRAY(COUNT, (sizeof(MULTIBYTE)), GFP)
++		ALLOC_OBJS(MULTIBYTE, COUNT, GFP)
 |
-	BYTES = ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
+// Exclude other multi-byte arrays:
+//   s16 (*pairs)[2] = kcalloc(n, sizeof(s16), gfp)
+	ALLOC_ARRAY(COUNT, (\(sizeof(MULTIBYTE_TYPES)\|sizeof(MULTIBYTE)\)), GFP)
 |
-	BYTES_PTRS = ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
-|
-	BYTES_PTRS = ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
+// Exclude other arrays assigned to a multi-byte pointer:
+//   u32 *p = kcalloc(n, sizeof(*hdr), gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) = ALLOC_ARRAY(COUNT, (\(sizeof(E)\|sizeof(TYPE)\)), GFP)
 |
+// Exclude arrays of void pointers: kcalloc(n, sizeof(void *), gfp)
 	ALLOC_ARRAY(COUNT, (sizeof(void *)), GFP)
 |
-	ALLOC_ARRAY((sizeof(void *)), COUNT, GFP)
-|
+// Convert any other expression: p = kcalloc(n, sizeof(*p), gfp)
 -	ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
 +	ALLOC_OBJS(E, COUNT, GFP)
 |
+// Convert any other type: p = kcalloc(n, sizeof(struct item), gfp)
 -	ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
 +	ALLOC_OBJS(TYPE, COUNT, GFP)
 |
+// The same, for arrays allocated as (size, count):
+// Exclude byte buffers and integral pointers: kcalloc(sizeof(u8), n, gfp),
+//   kcalloc(sizeof(char *), n, gfp)
+	ALLOC_ARRAY((\(sizeof(STRING)\|sizeof(BYTE_TYPES)\|
+		      sizeof(BYTE_TYPES *)\|sizeof(MULTIBYTE_TYPES *)\)), COUNT, GFP)
+|
+// Exclude arrays assigned to a byte pointer:
+//   u8 *buf = kcalloc(sizeof(*hdr), n, gfp)
+	BYTES = ALLOC_ARRAY((\(sizeof(E)\|sizeof(TYPE)\)), COUNT, GFP)
+|
+// Convert a multi-byte array to a pointer to it:
+//   u32 *p = kcalloc(sizeof(u32), n, gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC_ARRAY((sizeof(MULTIBYTE_TYPES)), COUNT, GFP)
++		ALLOC_OBJS(MULTIBYTE_TYPES, COUNT, GFP)
+|
+// Same by expression: u32 *p = kcalloc(sizeof(*p), n, gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) =
+-		ALLOC_ARRAY((sizeof(MULTIBYTE)), COUNT, GFP)
++		ALLOC_OBJS(MULTIBYTE, COUNT, GFP)
+|
+// Exclude other multi-byte arrays:
+//   s16 (*pairs)[2] = kcalloc(sizeof(s16), n, gfp)
+	ALLOC_ARRAY((\(sizeof(MULTIBYTE_TYPES)\|sizeof(MULTIBYTE)\)), COUNT, GFP)
+|
+// Exclude other arrays assigned to a multi-byte pointer:
+//   u32 *p = kcalloc(sizeof(*hdr), n, gfp)
+	\(MULTIBYTES\|CONST_MULTIBYTES\) = ALLOC_ARRAY((\(sizeof(E)\|sizeof(TYPE)\)), COUNT, GFP)
+|
+// Exclude arrays of void pointers: kcalloc(sizeof(void *), n, gfp)
+	ALLOC_ARRAY((sizeof(void *)), COUNT, GFP)
+|
+// Convert any other expression: p = kcalloc(sizeof(*p), n, gfp)
 -	ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
 +	ALLOC_OBJS(E, COUNT, GFP)
 |
+// Convert any other type: p = kcalloc(sizeof(struct item), n, gfp)
 -	ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
 +	ALLOC_OBJS(TYPE, COUNT, GFP)
 |
+// Convert flexible array structures: p = kmalloc(struct_size(p, data, n), gfp)
 -	ALLOC(struct_size(VAR, FLEX, COUNT), GFP)
 +	ALLOC_FLEX(*VAR, FLEX, COUNT, GFP)
 |
+// Same by type: kmalloc(struct_size_t(struct item, data, n), gfp)
 -	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
 +	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
 )
-- 
2.34.1

