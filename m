Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409173B8139;
	Mon,  8 Jun 2026 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912551; cv=none; b=QpenrFWu9M2vIhcX5UifESrFin4o/1bd/hB7O03WRxB7nwrT5DzskmsPydihx9Mw6tScCPKm4NyNsUJ5PYt2XmmwVFmK/6c2Nzn8o5ei5dY0JB6LVlnVHE+BjM2IRU2CI/eDWTIVApDKxCaIUu9oThhYzTtt2LUEhyrnkeh0FLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912551; c=relaxed/simple;
	bh=gB4CJM9dP7in9QBwWMOp90LxO7ryMvd+O+GFiDZwdvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6sYzuKz6x6re9KMRvCTxQA8w38en1GwKRmfawu3fP26ZOJa4ZNbbJze91ALXEdjXyna9yFH6MaNAPoKPrcjO31oiRFRx/ZxiJanjZfFv7t3MYFEOnNhIWsXA/ICuMJb4u0PZCXRzpoWzne4ZT25HIiZ33SSJFxI8vNh5cVOMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=lflMKSt5; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="lflMKSt5"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWho-00BrAE-WD; Mon, 08 Jun 2026 11:55:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=XEzj64Mq/Yif2RRJnb+y71DCUVrc4J1PwqxH8n6Ogl8=; b=lflMKS
	t5ulsiWL6QGMU8oH8KDRYOsnyANbP2QsbnPr5pHyxNFST52KXNjcozzRosjM04VbpU8o74GyR6rLH
	21nGWJKY7q9mxgtyN4YVpm5hU1GrFBga2i6iimgV1l+wrZBUJ9DaFwFN8sA6s6MwW59yDxbJzTJUN
	gkgze2Fa3GkiSeQgbb2ZOvDmtEULZxN/kpxBbTRyqBJDvJYvbH7FdpYU3reEg7xmb+0/baoW75Gha
	WXIxvpYdhN7i+PpETeE8wvWcmZtYxjoSX+PqaCWGrAtZhLDX1z5/NjJdCWxdtUe3sMFjATI7SHrNE
	ylizOgXJiPcqmYYq/Ld0+SlkWrPg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWho-0003dA-6N; Mon, 08 Jun 2026 11:55:40 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhe-00Ag6G-M6;
	Mon, 08 Jun 2026 11:55:30 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/devlink: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:57 +0100
Message-Id: <20260608095523.2606-13-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 net/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 485029d43428..108926d3f899 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1222,7 +1222,7 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
 			devlink_port->type_eth.ifindex = netdev->ifindex;
 			BUILD_BUG_ON(sizeof(devlink_port->type_eth.ifname) !=
 				     sizeof(netdev->name));
-			strcpy(devlink_port->type_eth.ifname, netdev->name);
+			strscpy(devlink_port->type_eth.ifname, netdev->name);
 		}
 		break;
 	case DEVLINK_PORT_TYPE_IB:
-- 
2.39.5

