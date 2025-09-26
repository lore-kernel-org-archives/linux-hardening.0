Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161F27B342;
	Fri, 26 Sep 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758912548; cv=pass; b=ZZSovRWwfE+/OhG7mRD6p3XCUeFLTtt7YM3oIhv/kgrZ/3hVziQB1E3ucer0g3SuaKHB1Lng4LMJfpkZTj52dlUEvozu3KT0FrfEuQdbLLyiD1vI05EqFIOthfVgUu36fawOOB3RNGTSGEuAXFObeOFdnDhFWy/IExeN9/kOu50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758912548; c=relaxed/simple;
	bh=nqhrpCPg22+qqPH/cP8awDrzjP62bZ1uCIVrWt7AZTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBxmfA/6Bmmgu3UjnUQgHu151EtSXX4BQxtEFos+A+iIOgHSvqzfabGbM/baYrgqsRTiMq9XVcqVs/MBnpGlLsEE77gm5RHueFkveO/51BZwzb620AdFrzkHsQxdTFLpGRP80bNoI0UIz7wQuYb/6FbXq8RId8kLOzlG2riKcMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=EOcGf0zP; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="EOcGf0zP"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58QImWfF080629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 03:48:32 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id B388310A24946;
	Sat, 27 Sep 2025 03:48:31 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0PbXkJIVm4R; Sat, 27 Sep 2025 03:48:27 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id ACE58109D57DE; Sat, 27 Sep 2025 03:48:27 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758912507;
	cv=none; b=ge4yeT6Nb0AAdFCMPWSh1TVc+kX067GdqxeZrVk9XzTD9Zu1ZjKh+oWlTPbyDvFU9A/AfFEUuinwJzzo2eMg5q/hZkBRluaYV64zhveATUOOEX+NMlhYAKxI54HXxa0Qcg05cIdEHBHecujpCdJZgLln5/ORsJnZC6nd3UFBKlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758912507; c=relaxed/relaxed;
	bh=6skZ6w2rUgfzz1RrgmD9s09Pm7j+TCfwgPr5WI1M9tQ=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=Hp0nwbP9sKtH/50EwBvSOys0T7WV02V1IG5gxZfrZQMAQxZT91H2Dm9aVimK68rZvKw8JMjEN1arobLzFx82y++qf00BZjTJxQtYfF4t2taNrXOnES+V61HByWKkwbFEt84kj8GUSOxJdJq7wewCQuZFkjR+DAhSgwSqBuKAWh8=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org ACE58109D57DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758912507;
	bh=6skZ6w2rUgfzz1RrgmD9s09Pm7j+TCfwgPr5WI1M9tQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EOcGf0zP4Bwpck96DttCu/e/RPDtVrxk6WEbpm6puMd66x75YikPENFSMhYzOBZ/m
	 TmPrJtqSs/IWFEngLLYwpWVmOHRJZ0PvxEh92RbbjsUwdfRM1Dv3iMxPEZze0zxjwr
	 zJlOg15V4LDBtky7AoxXR+vmPSHj2Gv3XpoJ3uJM=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] Documentation: admin-guide: Correct styling of MS-DOS
Date: Sat, 27 Sep 2025 03:48:24 +0900
Message-ID: <20250926184824.40270-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"MS-DOS" with a hyphen is the official styling. Change the
less common "MSDOS" to "MS-DOS" for correctness and consistency.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/admin-guide/pstore-blk.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin=
-guide/pstore-blk.rst
index 1bb2a1c292aa..1e2abb2ef500 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -59,7 +59,7 @@ When pstore/blk is built into the kernel, "blkdev" accept=
s the following variant
    with no leading 0x, for example b302.
 #. PARTUUID=3D00112233-4455-6677-8899-AABBCCDDEEFF represents the unique i=
d of
    a partition if the partition table provides it. The UUID may be either =
an
-   EFI/GPT UUID, or refer to an MSDOS partition using the format SSSSSSSS-=
PP,
+   EFI/GPT UUID, or refer to an MS-DOS partition using the format SSSSSSSS=
-PP,
    where SSSSSSSS is a zero-filled hex representation of the 32-bit
    "NT disk signature", and PP is a zero-filled hex representation of the
    1-based partition number.
--=20
2.47.3

