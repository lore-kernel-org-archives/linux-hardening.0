Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814501DA28
	for <linux-hardening@vger.kernel.org>; Mon,  2 Oct 2023 16:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA69BC433C7;
	Mon,  2 Oct 2023 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696263271;
	bh=z2fk8YtqV+V10VoyiNxtWZBlzYiMUwqKV/e12y8Dpx0=;
	h=Date:From:To:Cc:Subject:From;
	b=GbwsDYRm+UDgIYREREAZP0jTTQBCIV4CJJHH7wEetdjC+jxysZa0rBH8QzAwzAFwZ
	 v7lxoCioIVK/r5zbt1IOpNUptgXs7b3khb6v3d7hOAEGjrnJJ4yvcESo7MtDHwXTDP
	 VdkN1SdElzRobMstfIArea3xeRsFkk8p+DIIEkIFGhJ/oqwOipzgGy0oLPoMTcuM8S
	 3u67P2ISVpF4mDi/QhrtiiQdxlSnVoCP0S6B8GM98iE4Yse5HtdyRDf1Ljk5oPm8N+
	 6V8OiI3ER7Dx0VnidTST7wrI//SY7+4gj1/0fHBNLzT2sbyzOLUScUS1vNSaxojfOO
	 bwl94dkd8l2sw==
Date: Mon, 2 Oct 2023 18:14:26 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] udf: Fix undefined behavior bug in struct
 udf_fileident_iter
Message-ID: <ZRrsYkKIQe8K6F/t@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`struct fileIdentDesc` is a flexible structure, which means that it
contains a flexible-array member at the bottom. This could potentially
lead to an overwrite of the objects following `fi` in `struct
udf_fileident_iter` at run-time.

Fix this by placing the declaration of object `fi` at the end of
`struct udf_fileident_iter`.

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Fixes: d16076d9b684 ("udf: New directory iteration code")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/udf/udfdecl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 88692512a466..736f591abc89 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -93,11 +93,11 @@ struct udf_fileident_iter {
 	sector_t loffset;		/* Block offset of 'pos' within above
 					 * extent */
 	struct extent_position epos;	/* Position after the above extent */
-	struct fileIdentDesc fi;	/* Copied directory entry */
 	uint8_t *name;			/* Pointer to entry name */
 	uint8_t *namebuf;		/* Storage for entry name in case
 					 * the name is split between two blocks
 					 */
+	struct fileIdentDesc fi;	/* Copied directory entry */
 };
 
 struct udf_vds_record {
-- 
2.34.1

