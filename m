Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA635896
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 11:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA6DC433C7;
	Thu, 28 Sep 2023 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899126;
	bh=Ss7nLMp7jLyE6miSYsprdXK+tzY89Wa3eXUpvyW77Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GB2bi8+hguQ/MH1kAXUuU1IWliWyqT+gj6ORqRdaqWx//xKgrh1/giZmmtA0PgxlV
	 rCEHfaQ13m8Us+1ADvEN2ugG/nb4keyAFRhGOm8yKDERmEeTsYGpKW0iWqBcVYtpzx
	 krqs7C229KDYWJBITkNxFK6MQepOt2qb1WwCSbwl5WuLVo2d2dBUoC3xqX+7WG+pyz
	 H8jUEK3UgzBkIVDoCUuUYqpNu6hqefcY/Uztmbu/pzphpYJtazLsEiWG5IOvsND2rX
	 YglEz/g6FYTpmXddC01mx+F9+X+DITp17pceumXx3RkrGO17iP3ezLmJMG5F2SBnCM
	 NhjlPxSnCmeRg==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 61/87] fs/pstore: convert to new inode {a,m}time accessors
Date: Thu, 28 Sep 2023 07:03:10 -0400
Message-ID: <20230928110413.33032-60-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/pstore/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 585360706b33..d41c20d1b5e8 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -223,7 +223,7 @@ static struct inode *pstore_get_inode(struct super_block *sb)
 	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 	return inode;
 }
@@ -390,7 +390,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	inode->i_private = private;
 
 	if (record->time.tv_sec)
-		inode->i_mtime = inode_set_ctime_to_ts(inode, record->time);
+		inode_set_mtime_to_ts(inode,
+				      inode_set_ctime_to_ts(inode, record->time));
 
 	d_add(dentry, inode);
 
-- 
2.41.0

