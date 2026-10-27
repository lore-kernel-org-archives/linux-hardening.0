Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101410;
	b=kvox7zvCSImVGPjGAZb7tZoO4QbuI4+5gLJhr8YNGiQq3BNXVfeJ9CC4EzZ/1rwR4okh
	 Ixk9/O4n7sd3/OUDaze/m7vbihGXyF1AVV54xhSE/hfl7k7Piu/9EjRzCbB8tXmX01uEG
	 07n2Jowhn7q4gXCfLyPLt+8EAQvYTWQkYEbQY3iGGk6JbUIcU3LBteDkhF2Oa0DKoy+dz
	 12VSr0+8CWNruHdf44tRnyYDqUC1eFQMol/ZvPaTZRMRNknte7EK5tgVoaVg4QzvPgMLh
	 hmfXeBKL7GmJJcXIgGfsefW7nfE9tkheNkWLlksNJbERNHFMVFQqvAtQb9oGbmZZwBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=qRj5nmSVr8oaHYTfwp3nV+7muLaSPF1hwSVuKOsZ4eM=;
	b=jZWzT5bhWZuwuAkT20pdZCcu7STHuQ+eM7+Kz1lc4QulVss56i5oO+HkQYdPzxa10eG7
	 a/Gv/7mrBcW9I+IVLVyqgoPecUgOskFH4PjYqLJmims4sABRAGMh+oKH0bFNJ3/8PmypT
	 53EOWKBKU8+CSw6Ng+mqAbm9Bp0XPdC8sewIZezaLZOdT19ehJ+Ac8Sf39tP9XyD+UQ+v
	 T1Op5AUrkCZpeZndnWDjxtNR9t10VQukjQhGrQTd1J591rUpFXTdB5j1wY5aZLDVxcpr1
	 veqisyqClQSRxBVsnHZllJhigQaGtm88asLCl2/eKVBUVS7WCTPKJyV0YnFZ5/ELwUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="iBOg8BS/";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E1606A9C2
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 11:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 151E1606A9C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=iBOg8BS/
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so834248a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793101409; x=1793706209; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qRj5nmSVr8oaHYTfwp3nV+7muLaSPF1hwSVuKOsZ4eM=;
        b=iBOg8BS/AfD0VOTVMWP3REB+11vPV7w0ToTM56EJrWZAxVXDxPmG2MqW8hvNvUbI+l
         YLBtKH1cr2sx6cgkWNqYFi3Vz8TZKPEM4+mP4lXO1mL58LsaQeFs/aZsyjGzeSlcZ0Lb
         r9YN/CYxzdAX9OSGZqJcz9kVZHtlPumWOo/gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101409; x=1793706209;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRj5nmSVr8oaHYTfwp3nV+7muLaSPF1hwSVuKOsZ4eM=;
        b=b3HZp5jnMQ6aEKmyNIoINkUJYp6HgoDbwZ0wc4lDkVNSTTpT4URrft2fdK6cDGOzwn
         Nxp/bYK88CxV9YTquwDSvK+cTV1gXoZtDmOdnxc8Du4QxjCIbmF8xAObMDvi+qvUCsvN
         2PQtvAmNXD4ArpJIP5bTGwi0XlsX20zRi9IXOvL1RcQdiMHDr1ViendUAYvLw1Mj13vP
         jT0Th423VxGsIUcqERKx9pOmOgMyRimFhNZdB3H2gn3umQv81OASPWCLQknMyIDyjKxN
         qWr48nFAFq/6cJRxHhQhDxBHM0OW/xS+HlY582pOlZOFuGTa+UIgvIsMBmVh3d5Qntat
         j5UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxp8h6E3MQ5/ZpHtG9eIY6JUedHRJCYDDVQStq+WvdbShbL+ltp0ORopBcALLdQG784R/ZRdm5TnfzzDtdNitk=@vger.kernel.org
X-Gm-Message-State: AFq9FYID6xi+enymG1fXouDqMacSD4XfV99aDuep8iRtSs92Amar/Vyg
	LtzW5nSayFPOVZTaNYYLEY56QUI5w3Aejp+ePJ+pMQADvB37MWol8hKjBQfNx7cRlfs=
X-Gm-Gg: AYBFou3Fawf7GH8fW2PDkpedWSYZ2kxnWIF9y7I7HsVYknlLxYMYKN5K6Q8D4U3M3v+
	dy8xACa5EGUNXC4rE5HNVAjgxLccPcacEH8m9nZVj2v3e5q28MgPZdiXMKdblrWus8OhW1f/vAY
	bqYrauuHAw8snK943ibbLWNidWl+quweaICYFmqs3p+F5TeIJLHfh885txW0mBQj6wft8DRhlur
	eQdcQE1LuGPOUZt/wCorqAagOAqS4j1VRDsTIBznCDxBbkKi7mfClXSLvI/dwP6icajyg/NdM2J
	10yXz20FCPiv19IVkFXolgvfwJWC/cTVdAImRPUEx13AaKLtcUgaIrsu2TcnVNRYMOF9QNEklzt
	wtC9ahRfRs1OWOTD9gbF9KRDUAft0rF2XsCE57hhx0w7OP1sJNxYAj5MT8W1bRgUtEE3DjnwezA
	ta2v3JHtWBOounDyNNNtxugJrJHgR4S8t/REGBHknjgPZWdPRFuvn75jhUobEK8mHYYezfo/eWd
	qJYYAPENe8zoj2e1ynwRjyWbxCxr/YfU1T1mGW/FuISP6MWP/j+X2SAhDgTFviTEuYylg2LLVjW
	uLnxYiBLoRYz/jtEJ/SOU1OvZre7BbaB6rvgAA5TmgN5LMhkkjztb5/Sg015lWQUmTmClbegNqp
	CLbe3J0PBUF4rhx9QHU4kYto=
X-Received: by 2002:a17:90b:35c5:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3adeafb079amr6566975a91.34.1793101409391;
        Tue, 27 Oct 2026 04:43:29 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adf8f3f22csm7120822a91.3.2026.10.27.04.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:43:28 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:43:25 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH 3/3] selftests/mseal_system_mappings: Test vdso unmap and
 remap
Message-ID: <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793094611.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../mseal_system_mappings/sysmap_is_sealed.c  | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
index ea75ad537620..83b4fadfbfe7 100644
--- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
+++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdbool.h>
+#include <sys/mman.h>
 #include <sys/utsname.h>
 #include <zlib.h>
 
@@ -232,4 +233,95 @@ TEST_F(basic, check_sealed)
 	EXPECT_EQ(expected, sealed);
 };
 
+static bool find_vdso(unsigned long *start, unsigned long *end)
+{
+	char line[MAX_LINE_LEN];
+	bool found = false;
+	FILE *maps;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps)
+		return false;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (strstr(line, "[vdso]") &&
+		    sscanf(line, "%lx-%lx", start, end) == 2) {
+			found = true;
+			break;
+		}
+	}
+
+	fclose(maps);
+	return found;
+}
+
+static int vdso_is_sealed(void)
+{
+	int sealed = -1;
+	FILE *maps;
+
+	maps = fopen("/proc/self/smaps", "r");
+	if (!maps)
+		return -1;
+	if (has_mapping("[vdso]", maps))
+		sealed = mapping_is_sealed(maps);
+	fclose(maps);
+	return sealed;
+}
+
+/*
+ * Unmapping or moving [vdso] must fail with EPERM when it is sealed. When it
+ * is not sealed, it succeeds and leaves glibc with a stale vdso pointer, which
+ * is fine because each test runs in its own forked child.
+ */
+TEST(vdso_munmap)
+{
+	int sealed;
+	unsigned long start, end;
+	int ret;
+
+	if (!find_vdso(&start, &end))
+		SKIP(return, "could not find the mapping, [vdso]");
+	sealed = vdso_is_sealed();
+	if (sealed < 0)
+		SKIP(return, "could not read the [vdso] sealing state");
+
+	ret = munmap((void *)start, end - start);
+	if (sealed) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EPERM, errno);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+	EXPECT_EQ(sealed, find_vdso(&start, &end));
+}
+
+TEST(vdso_mremap)
+{
+	int sealed;
+	unsigned long start, end, size, new_start;
+	void *dst, *ret;
+
+	if (!find_vdso(&start, &end))
+		SKIP(return, "could not find the mapping, [vdso]");
+	sealed = vdso_is_sealed();
+	if (sealed < 0)
+		SKIP(return, "could not read the [vdso] sealing state");
+	size = end - start;
+
+	dst = mmap(NULL, size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, dst);
+
+	ret = mremap((void *)start, size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
+		     dst);
+	if (sealed) {
+		EXPECT_EQ(MAP_FAILED, ret);
+		EXPECT_EQ(EPERM, errno);
+	} else {
+		EXPECT_EQ(dst, ret);
+	}
+	ASSERT_TRUE(find_vdso(&new_start, &end));
+	EXPECT_EQ(sealed ? start : (unsigned long)dst, new_start);
+}
+
 TEST_HARNESS_MAIN
-- 
2.54.0

