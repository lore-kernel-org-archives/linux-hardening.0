Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508A82E648
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJNtc0SC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E783C433C8;
	Mon,  6 Nov 2023 22:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699309625;
	bh=OsFOBVxFJvsI/uYfcFoJ/iuijJol3ip7nWPD89kIj7w=;
	h=Date:From:To:Cc:Subject:From;
	b=LJNtc0SCBRgrlXe9i7WinH43s6BN62vqpq0jBsRmbjYjUQ10dmyFxffqoAkOPTujA
	 x9KpU3bL4vQxmAna3pwHcrNu4HyqNKvCBuZATQPM/zJdE8RhfVVKfsmdRxyprCCIwW
	 zpUCgsSkexes4U7+l8Ws3DkuMD16cA+R/ddC14mmV8j9xLCH8ed/6DZOgQUgVpS169
	 RJPGeVn3NuceU8OKi1EnDMszJ3YqD5Zxd2zu5hP+/hv1T94Jb6YIVEKuFYD/5NuCZg
	 DcdWRXPRY7Iigop7zvgsz1pv3Z3uScg25tF52dNbpLk1QtA5Kjg6qpkBaQ32j8CVLr
	 KSlPEjWXmQEiQ==
Date: Mon, 6 Nov 2023 16:27:02 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] bcachefs: Use DECLARE_FLEX_ARRAY() helper and fix
 multiple -Warray-bounds warnings
Message-ID: <ZUloNt0HSulJgZNH@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Transform zero-length array `s` into a proper flexible-array
member in `struct snapshot_table` via the DECLARE_FLEX_ARRAY()
helper; and fix tons of the following -Warray-bounds warnings:

fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.c:135:70: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]

This helps with the ongoing efforts to globally enable -Warray-bounds.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/bcachefs/subvolume_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/subvolume_types.h b/fs/bcachefs/subvolume_types.h
index 86833445af20..2d2e66a4e468 100644
--- a/fs/bcachefs/subvolume_types.h
+++ b/fs/bcachefs/subvolume_types.h
@@ -20,7 +20,7 @@ struct snapshot_t {
 };
 
 struct snapshot_table {
-	struct snapshot_t	s[0];
+	DECLARE_FLEX_ARRAY(struct snapshot_t, s);
 };
 
 typedef struct {
-- 
2.34.1

