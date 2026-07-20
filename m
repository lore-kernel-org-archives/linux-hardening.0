Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05081386C9;
	Mon, 20 Jul 2026 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540154; cv=none; b=PraWDVmcQHGw2QKBNryGBOvHChLaeXgUTZAs2M3RqNO3DeEot/erIHn9fSx60CgaIA4CiyrvvGrkNr9Tgjlvw1R3lYt8JKselYWuBIt8bTgJ0GOmNf0drTQviISCbMH6uGlL/C8vUB/TQJJL36eotmpeA07TuqQJQiNAYcDj0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540154; c=relaxed/simple;
	bh=iII6wqnm+5B9OVHGVB1MT6VVZ3YhWPXsHgRbGinMXdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNB1R7N4qDMp/ckWrYQWpWI08ZkyDCGRDDev6lvzXTHEVcuB7u/vbQEmrb/adETey3BUn4yCa1NhUSwWLFRXu392baE2X3Z7hlUy0MTqfkhsJrY/8cX9mEiqhaujJvIV+NDpwbSUF+3z5EUEYwPJ0/hH2fKS+knJHWtE7GIBnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=juF1203f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="juF1203f"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K87PXP2000627;
	Mon, 20 Jul 2026 09:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VcI+K5piI4K3AMqBu5lUr/aCUdp2IwiDfby
	Yiogdw+E=; b=juF1203fUwVLSNaCfFzGE55fYCXwHfafNtdMaXj2JVXOSH6E1RF
	ITaufYzshWOf/cZ3XBViBByHeUd2hiLH85RTt1y3uP7mZnsNoHFZ3/xSe2xuD/9t
	3kVy1iqLfde1eSCVJrKK7Y+XHaJlUoS2JNL9JyxxM67N1vRO+4fESE0NWtizDlUH
	dpR99myP59Kbc9heR67k6lmXY2TQj+XJboIo+0UHpo8veb223kRMjnYKrhWW8N66
	JLAt4i7athbcIW4rQj59JqWv6DH7LS8K9DZKdqzkYbgfkqh5ghD6iF1USEx4Dbum
	ZEdnWB05YNKfyJSf5E2QJsUzhQBNgYEshEQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxge7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:35:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K9Zk6u005810;
	Mon, 20 Jul 2026 09:35:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fgj53by73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:35:46 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66K9Zk69005800;
	Mon, 20 Jul 2026 09:35:46 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-jaihindy-hyd.qualcomm.com [10.213.102.234])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 66K9Zk5d005797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:35:46 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 448081)
	id A0EFF22A51; Mon, 20 Jul 2026 15:05:45 +0530 (+0530)
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: nathan@kernel.org, nsc@kernel.org, kees@kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: gustavoars@kernel.org, linux-kernel@vger.kernel.org,
        Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [PATCH 0/1] scripts: kstack_erase: avoid absolute stackleak plugin path
Date: Mon, 20 Jul 2026 15:05:44 +0530
Message-ID: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5debf6 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=QmHdReyqfKBWz99AovQA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNiBTYWx0ZWRfXxQU16So5z+Ui
 tCM4pxfnip7wj+qXg6ZgO8mXt/vl+y39fS7dP3JBwi7/PGOmNCB4nLSbyNJiJvVa0v6zSYDsGaQ
 s9o+8TpTzP/PTMivu80xkzEDpSCixJc=
X-Proofpoint-GUID: zTg5w2GJsnLmJ08ALDkI0Cg_gFD7mtes
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNiBTYWx0ZWRfX+dpcFetPvYPV
 BZUK7TDe5ER6niBtQgGKA4PisQ193qOcVR/klMc/EbQyYTvYUlB5mLwyvNN0bDQwJQuNyuAlRb4
 /cPi5EveDQs3jgn4DgEYNwNSgOzQrKxDaMnD4iNW6cxpVACUe4ZLHewQ5E0f82Vu+YM3/67mCC5
 Z4myfPXRn1DKEWQ2NJRndzTjEVwz22LTDxQYjvjaAJF4MA+xoM/PuRkRRVaoG+UsHnh0Lcgc2He
 aCLDrkqt10bnqn99eNdrG0UQ/YxfaCoCgz5oUI/acXdZW8W7UIfCCBnIxfUuf0VbRVjts+SRql0
 7/lasjp+OiXeCGh2gxTDmqngAntEnlhxuTVX2Dm05nju5Pc2Nw7C+W8roDyMFvpU1nu8B3bdg8U
 JyDArJx9MplGwl3tKotolXvFJrd2GbyMMTXAz89qV9htWMLWgycKUjqOgKbTzPCO3o7jI+GbYy9
 u9MhV9NJKZ8xTTVY19w==
X-Proofpoint-ORIG-GUID: zTg5w2GJsnLmJ08ALDkI0Cg_gFD7mtes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200106

Use a relative -fplugin path for CONFIG_KSTACK_ERASE stackleak plugin
invocation to avoid embedding absolute build paths in recorded compiler
switch metadata.

Jaihind Yadav (1):
  scripts: kstack_erase: use relative stackleak plugin path

 scripts/Makefile.kstack_erase | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.43.0
