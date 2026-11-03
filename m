Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724133;
	b=rp3jWq14Q3jhSgOnDYnyZ93W8vcOqPf85JRATSgzwFf93SKb9RMYzaSBl9qPMJq7jh8Z
	 62D40qnl2jtOZByV1VLEf1V9bYSDFQxQqKz0v//0dwhJDk4GdQ8LantpviD/pPvqF5FLr
	 kfFb9duYZd46AJSolvLGBUVXKuvVso78ViHwM5RQBdrihXo1FoqyKvrfh2bOFhCqJ6p71
	 a9Zp1u3UrqA6gxYr7SaFXz5GOOQYUivPQicdJ4qoLWdNN1bDUw7dZgjPmY7/R4socas0c
	 kcNMY0jw+D16oRtQOCTxnKt2anwRVXNwX2y4OiGZbpfCCsRxkZuVBzYg63bN6SvFJwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724133;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=S6JfyyvRxL4l1fMHMFvG0I2x91FsQ1UDGLPjBWHtnow=;
	b=Ta+rx7qao0AFpOnY6dZYDkZ+oW0a8iS5j3N3LGwvHWGGIknfPSnWuFlPwQ5rMU9vYh+K
	 uKXLeY1D0Cspc7u2L1rPRidxsTUyKfKmjYCI6M41Pz+GMUlFwPV8OeA2BVHYfPPVfWl17
	 w5jDuFmLZNPg07AoHJbL8S1+LWO12yKS3NCGb1+7U4aebJ/ZJmOiQYn3BF40Olx3ZjCD3
	 BPyd5AjUWOELN8r7hKeAOYhiQEizZXOg4nfowbHYhpFtc+cghaMcNdxIWZ3/qs6USdcI0
	 v60DeNejvBFEcqcDYhJ7Od94nsG/Pg2mx8P3wHcXY+U+1hXDiRDuqjP2/QCI9eLmqEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=daylightlinux.ch;
	spf=none smtp.mailfrom=daylightlinux.ch;
	arc=none smtp.remote-ip=83.166.143.169
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC560A5BDC
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 16:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70DC560A5BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daylightlinux.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daylightlinux.ch
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jJvVj3s11zF0C;
	Tue,  3 Nov 2026 17:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daylightlinux.ch;
	s=20261016; t=1793724125;
	bh=S6JfyyvRxL4l1fMHMFvG0I2x91FsQ1UDGLPjBWHtnow=;
	h=From:To:Cc:Subject:Date:From;
	b=HdKBytL7t8ouUXDKbGUk6d9tAhEUSDBAIUTmSaKdHjnmmszspRpcxiyxUHfNFwBrP
	 OTIHi14UR37g9FTai4Dt/W1YJIRpQ79Dfy9d3MeqSWet6Z5zn46El9pc/RhqTMyBRw
	 rsMGrO1FKJeVokfZJpq/E2j5f98vVlAqt23Isj0erSPvFh0hwmPaihN+mD75M7vXs/
	 mJXeTBDe2PfWmiXD1AgKWYISxNss1F6GooKWBTbkmInDtp1lvSZxVwMyQtaNW22ziM
	 XgGjYSJ3XC2HDIyQv5ZkEgJNCwsGoaWPa8Fz/SifJbamm/r0q5mDE5PfOioxwxJiNg
	 pvfFpveeVPEsA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jJvVh5yFlzy6H;
	Tue,  3 Nov 2026 17:42:04 +0100 (CET)
Received: from unknown by raspberrypi with local (Exim 4.96)
	(envelope-from <info@daylightlinux.ch>)
	id 1xOHaG-00FDcV-1M;
	Tue, 03 Nov 2026 17:42:04 +0100
From: Hamdy Abou El Anein <info@daylightlinux.ch>
To: kees@kernel.org
Cc: hamdy.aea@protonmail.com,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH] randstruct: stop seed generation when a command fails
Date: Tue,  3 Nov 2026 17:42:04 +0100
Message-ID: <20261103164204.129671-1-info@daylightlinux.ch>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Hamdy Abou El Anein <hamdy.aea@protonmail.com>

The pipeline ending in tr hides an od failure, allowing an empty seed
and its hash to be written successfully. Similarly, cut masks a failed
sha256sum, and a failed seed-file write does not stop header generation.

Enable errexit and capture od and sha256sum output before formatting it.
Compute the hash before writing either output, then stop if a write
fails. The seed format and hash calculation are unchanged.

Tested normal generation against Python hashlib, injected od and
sha256sum failures, and an invalid seed output path. Failed generation
now returns nonzero and does not create the hash header.

AI assistance: ChatGPT/Codex identified the issue and prepared the
change, commit message and executable regression tests.

Fixes: 313dd1b62921 ("gcc-plugins: Add the randstruct plugin")
Signed-off-by: Hamdy Abou El Anein <hamdy.aea@protonmail.com>
---
 scripts/gen-randstruct-seed.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/gen-randstruct-seed.sh b/scripts/gen-randstruct-seed.sh
index 61017b36c46..d3c4c1b59bc 100755
--- a/scripts/gen-randstruct-seed.sh
+++ b/scripts/gen-randstruct-seed.sh
@@ -1,7 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-SEED=$(od -A n -t x8 -N 32 /dev/urandom | tr -d ' \n')
+set -e
+
+SEED=$(od -A n -t x8 -N 32 /dev/urandom)
+SEED=$(printf '%s' "$SEED" | tr -d ' \n')
+HASH=$(printf '%s' "$SEED" | sha256sum)
+HASH=${HASH%% *}
+
 echo "$SEED" > "$1"
-HASH=$(echo -n "$SEED" | sha256sum | cut -d" " -f1)
 echo "#define RANDSTRUCT_HASHED_SEED \"$HASH\"" > "$2"
