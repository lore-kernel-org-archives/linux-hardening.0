Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4333991;
	Mon, 22 Sep 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550853; cv=none; b=IXrW58ILpFlyRO9FzPx2HWKDo2UVhG4W2boW1yu3QVr56GH3T4WvBDmhU7M8OH4VEcHvY5QK9rcT9sS3d2hV+Llmlcyt0J7MbPxglIT8YjTvMzj2swjQ0zI3IHtqKzlYYDXJXrd4FCU1RBVmuEwWeu7FQEQ/OKbWJ1lgCN5Q6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550853; c=relaxed/simple;
	bh=R0weu+X08HQk2XnLPTCbBYzistuQhGHRMXvTiVRYJSc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HWLp7x2VzmN9iSGxik4DlfKDopryJtFl+fCBqY4XPcl21yeAhqDqIVRWJ3nQWOZLPUGU+CzCHqhZCWJbccc7xl/2vyV6nsABmPtuYGsC6BUht5jiQHjCyhc604G6ItMTZLdG8ZfMfP6mNGY5ylgUWgfymcsYV4IcwWbUR2G2Kbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CePgqQr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CePgqQr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F385FC4CEF0;
	Mon, 22 Sep 2025 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550853;
	bh=R0weu+X08HQk2XnLPTCbBYzistuQhGHRMXvTiVRYJSc=;
	h=Date:From:To:Cc:Subject:From;
	b=CePgqQr8sR7WqwUnA12bDvXCWWbEqAFHvlwCpGCPQxzd7K/6uwsZAnm/IkccuNzzV
	 DsvZzsymVLqjQfdyklRlyqLDeK19KpVKKBpizqwx1lGF2QhKYRMYiQYWtYbm2oDW+2
	 +SdNtytAwUMMSwx5dyfhy5pw8kuEIgK3HCvOy1nCV2zQABLhFZRxZsYdaJxYI9li1m
	 324WQQv/JNIZCinkTl7RHOCGe0F2KME9XxpuYfuQ0Wavm1wJgzNhuWPv2V7o8H+mhN
	 UTslUuU+mmkfcH9692DT6Z4Tzc/f42ILBnchLGp0w8Sz+mYrhOpQs8EBMjfvA15Ao4
	 gmbhMh2wyu43A==
Date: Mon, 22 Sep 2025 16:20:47 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] dlm: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aNFbP3UaRokBxruI@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the corresponding
structure. Notice that `struct dlm_message` is a flexible
structure, this is a structure that contains a flexible-array
member.

Fix the following warning:

fs/dlm/dlm_internal.h:609:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/dlm/dlm_internal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index d534a4bc162b..9df842421ae0 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -606,7 +606,6 @@ struct dlm_ls {
 
 	struct dlm_rsb		ls_local_rsb;	/* for returning errors */
 	struct dlm_lkb		ls_local_lkb;	/* for returning errors */
-	struct dlm_message	ls_local_ms;	/* for faking a reply */
 
 	struct dentry		*ls_debug_rsb_dentry; /* debugfs */
 	struct dentry		*ls_debug_waiters_dentry; /* debugfs */
@@ -665,6 +664,9 @@ struct dlm_ls {
 
 	int			ls_namelen;
 	char			ls_name[DLM_LOCKSPACE_LEN + 1];
+
+	/* Must be last --ends in a flexible-array member.*/
+	struct dlm_message	ls_local_ms;	/* for faking a reply */
 };
 
 /*
-- 
2.43.0

