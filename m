Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2D314B6A;
	Thu, 26 Feb 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098786; cv=fail; b=rqV24ZRa3zM0cXUZsFeRMEe1g2ucTt1MQ4hTlVV5QhoMQ7GeGH9jMuU3cmZTXIJ1l4o6uMOKZ7hCPUg0YHJV2L528pAtWzPZx8pAi8aahcB9nNlgIzdRpFvD3rwme9vChPekrNe1uVfPs/JAkioGB5Vi5Ce87Qy5mTh3LECC1iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098786; c=relaxed/simple;
	bh=PI+kDaIOeZx+l30YRsYhh8GwTIpgcs+0Wd7SwrsIJ4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCdm18yjg/yAeWSUgpDiTDgpgXz3F2EsdoQKhqIaA9CLUusmR0+9CxPhOrBBB/2sOOAarLBRZg45xbFs/UbPR+nxtzZvMR2BcuY7myZ/XNOWgL8tJSIfEvrTZKwop40jfgqUCKQ2MpvBlAkgYgt2RSA9UaIUl9TvV0UMdmjCaMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UCrdUgD8; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UCrdUgD8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUscVXLTZXO8VJZwnSbyw5iZKIvI+obrSqrRJAedoxlsc1HR4c2H5ZtZrxnKpmJf4ukiAiU+IPdiT0t7goVms0cg5rpLwbtg6bUxsriCL2Oi4B9F7VStBBVzY+xf17sy+7sNtXTJGQKgtRBr/k4KCacQLiuNUmcMSPCctLKLvVuCP/gFm66zRbD5YK6mQpjKjfHjUTShaFmUjUqf8xXzehLpN/qhhIgVH5Mfvyv0Sa6OSmddS27z2PvVkPZokbfyPhSbR0hOr+D9c/9R6ODwiStPJRiV2N298rWqLsdE4+MLZ8wRf3IMJDnlcMqgzWYq1X5dwse9tnx2jpzokRoI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7GWTN0t5MnEuaeC7NZXQRWtMxnmb8w4Fun8c//khGE=;
 b=B2p6PzcPAvH5LHS422uzCL8AuOo7n0n72+qE8Hitt74IysPZV1HEe7DOzbcS8Uz7lOdwaN1i4hiBXaOIC/KDTQPEyOU/X4oZw63OW/7dmMS7J4TJjU6PekkH9CabssfyRB7tYq8CEJoVF51v7ExSSZ34+7bQl/bEEWQdmfX+XTRPAAh2uGzdp7CnX389dnNEgjT62iTQ2xVM1kTM60leVZw0nyWHzRdFRGk5p9EMM67Jt2DjukszHH5GlRG5laxsrpLBtcWi77ix9Hy4NR/jiqKmUai9K2SHZZzdBeyqINGdlNfLpjB9J8/vzwrAaG0NxTL82wdqB2QtIRdqNm+u0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7GWTN0t5MnEuaeC7NZXQRWtMxnmb8w4Fun8c//khGE=;
 b=UCrdUgD8TzYtLlciVdm+gAD+DfGlRGGHLBa2pu7/H50KbNro8OK9PjdncSv8FAFbk+eFyAgT5vyBlOsbyQJUJmBlwgR0eq69UP3E0B2R6T+wmcFnIsFmX39It26q2FZ5+gEV96CgUPIFiV4CUM42bRii2Xl41wPJqKCpFLKoVys=
Received: from SA9PR13CA0161.namprd13.prod.outlook.com (2603:10b6:806:28::16)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 09:39:42 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::18) by SA9PR13CA0161.outlook.office365.com
 (2603:10b6:806:28::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Thu,
 26 Feb 2026 09:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:39:41 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Feb 2026 03:39:38 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v2 5/6] drm/amdgpu: store ib info for devcoredump
Date: Thu, 26 Feb 2026 10:37:23 +0100
Message-ID: <20260226093727.2584-5-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226093727.2584-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260226093727.2584-1-pierre-eric.pelloux-prayer@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: f11cb368-c2c8-4abc-c370-08de751af767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	YRanT51pnBSD0FjtzT9aDVQYhH5Rz3WsW8a1C/1v3+uCUyB0YZ8nwoVs7pDYDeKg7Kj7Jbbr8jkLdEV991gFpGUWDkqoXFNZuJ6r8Nua51QuNtF9JoJSjL3mIxrg/6cdw9nwE/5HiZ0ShXoZkYMamvC+XMRB4P1abhggsaQUDQUXh7NFs9RhtuqWFSnLNTOmbbwn//zeRT6Tounxz6P1a9rR3d5dtkzf9uBYUjAcNqJ/z19ZnklAIh7DGgVnqOi0UkRXvcbJlsEAnBTE1eESs4tIrXNG5Q3F2CYEF7iKt1QhkZ5do3yDNmshnobHJihQIvOmxVOsAxC8EgyQM+l3hglxiSdlktT5D2olFvxPOSAm16kaWk81IO15jY2+cxMA2d3qA/V35QhwePe3Cw7EVX3vBdM0etn0Hjil6UgGoBhQLtEyxen4lKOQKFkXGlkiuFwwp2S1UG6VPGtIrGt1CRVUK8B1Ej5dFczBEsBRULyr0rSxRItPCGxdu7Hk9v2rEkCN3Q386J/NZuciqUv5HJ6vkRD2TsaHCxlCPvvDgI/lP79JUrrHUZTr7sL1AtLe1ueMDWyka0IF80WYYT+F5h01w60wTtWIvqokqnb9N04KP339rNoqInATwxeF9vaYahStKnH6S5AQw/gEW1fUUvUk9oGqyZ3sfncf2AS0IJ+qJ+KZ/ayfeYzqjUxi3yq7lwXfM3/ToysiX+Em8HnrWgClAN+/9sKHwkFinLCUK/EQ48HNOqpcOiv+h97Mf3B7fdgW78A59eAqaemUevCr75rfSIgxZd1LDVOOormvpxdT5hT6OdKe39dtLxFbh1PeK4DvxDLaxqpnRuU7utRKzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3RIot1hjja3cQupIHCSwAgYX3u35iFa+chf/GCV0yNAUvvZdOrOHP2Id2bMWOndBVC9WpUhUpZ42JbmT5f9ou7Q18uCRqydntp2NnSciPxb/q1od3uex2yZKeijjnLwdeoEyhORqm16jFw6ne1bQhW4fFoBdYUx6XICH3Tfd3aGbHdlUN3Vo8mxeuHq1xFimJcsTts2BeGS0Wws3u/XQb325Pr1JYpNl1plTdQs1evwXYrVyDVlo0M4zMpSWWvrexGXoqsZ/zkfWWlai9/MQ0LQSHRYrBr3BdR/J5I4AFzY/dpux1c550G7PjX4VcHzBterBgod7ZWQRxsfpr7BJ+jydAdWdVHMtnV79KvwDnV8F40zvW+ELFuLNZcR489G2vnCAK081aUgL1MkCNV+IVxqFVJbfD5fAzHq6dOWxfsGRpr6yk0QNKi4S8ed/0tKG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:39:41.2952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f11cb368-c2c8-4abc-c370-08de751af767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779

Store the basic state of IBs so we can read it back in the
amdgpu_devcoredump_format function.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 13 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h |  9 +++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 0bf85ab43204..d0af8a294abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -387,6 +387,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 {
 	struct drm_device *dev = adev_to_drm(adev);
 	struct amdgpu_coredump_info *coredump;
+	size_t size = sizeof(*coredump);
 	struct drm_sched_job *s_job;
 	u64 total_ring_size, ring_count;
 	struct amdgpu_ring *ring;
@@ -395,10 +396,10 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	if (adev->coredump_in_progress)
 		return;
 
-	if (adev->coredump_in_progress)
-		return;
+	if (job && job->pasid)
+		size += sizeof(struct amdgpu_coredump_ib_info) * job->num_ibs;
 
-	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
+	coredump = kzalloc(size, GFP_NOWAIT);
 	if (!coredump)
 		return;
 
@@ -406,6 +407,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
+	coredump->pasid = job->pasid;
 
 	if (job && job->pasid) {
 		struct amdgpu_task_info *ti;
@@ -415,6 +417,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 			coredump->reset_task_info = *ti;
 			amdgpu_vm_put_task_info(ti);
 		}
+		coredump->num_ibs = job->num_ibs;
+		for (i = 0; i < job->num_ibs; ++i) {
+			coredump->ibs[i].gpu_addr = job->ibs[i].gpu_addr;
+			coredump->ibs[i].ib_size_dw = job->ibs[i].length_dw;
+		}
 	}
 
 	if (job) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 1c3d22356cc7..49486d1f6a5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -38,6 +38,11 @@ struct amdgpu_coredump_ring {
 	u32				offset;
 };
 
+struct amdgpu_coredump_ib_info {
+	uint64_t			gpu_addr;
+	u32				ib_size_dw;
+};
+
 struct amdgpu_coredump_info {
 	struct amdgpu_device            *adev;
 	struct amdgpu_task_info         reset_task_info;
@@ -58,6 +63,10 @@ struct amdgpu_coredump_info {
 	 */
 	ssize_t				formatted_size;
 	char				*formatted;
+
+	unsigned int			pasid;
+	int				num_ibs;
+	struct amdgpu_coredump_ib_info	ibs[] __counted_by(num_ibs);
 };
 #endif
 
-- 
2.43.0

