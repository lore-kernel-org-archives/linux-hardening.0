Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C079418E754;
	Tue, 18 Jun 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754067; cv=none; b=EI0Tjlzgie/Ie7d2YX8J/30QeT8J/CAS1ybDWgCpF+6l5uK319+of3V2gcUjKezWi3NWo/weSNAjjGh2nn4+6QtdIhdSxB3NPOPOjYsn1NtUrBBfWZ6EwcZlVNgTBRUvtI4D6HzvIIztsb7ug74Ymm46YiuvW9Q90ESif4RW5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754067; c=relaxed/simple;
	bh=O9eySkFBFFhyrOoADg7GSNhpc95wQVGdzH+2rsraOqM=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:CC:Content-Type; b=eoCZAj7eAU8J+LVMtkWiwOR1TwZVjZH7ftutg+/zSirC/j5LYWRFMCwsNZ4sgjTKICvsImSRKoLpNMd2zby+Ls6EqHNHCYiSooJge2wGZNNJeLNCI1D8252f2SvnrD4diUb1YerIVyXjl6TPDmZ9n47Zqj8bNg7HoEdTiv5SJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R99PvyYa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R99PvyYa"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILa25l014475;
	Tue, 18 Jun 2024 23:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=O6Y10khejXzVQe3DeWLM3x
	WF74pRoLDK/ugLwuZETo0=; b=R99PvyYarb1h/TWd4wiI4g4ILWHoaLuHXvioAB
	N4MjKWj6U1UnxPAuUybUPr22rvNd1e4AGEMCJlFJFTQ+QcF1TadkCZds+68epQ0x
	G0+yQGODfLCKEEHpE0k1tUxPBsqhVisq+o2CoDJItvYd+2fEAj8z/dv0zVM++agN
	d673G+g3HK8F8dehbVrO5+9Y1Urq+i0VAwXmGs/lfscYom9FtgfPgrVzrOr1U1M5
	1cWCX9jsnmHASETP8q16GYZOKcarweZYtlAy8VYk7UOVPtrTvVGYk4Dl82YNPM/p
	Uww1GGwvs5NIfXSK3jTQ4wlaHL18ZwejkQkbL+xsddqI2stA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9x062j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 23:41:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45INf19N027603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 23:41:01 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 16:41:01 -0700
Message-ID: <563b8f82-9865-40ae-85d3-055b3bcda7d6@quicinc.com>
Date: Tue, 18 Jun 2024 16:41:01 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kees Cook <kees@kernel.org>
Subject: mips gcc plugin issues
CC: <linux-hardening@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uSOCDu-RnnuaxYfRpDI6E_b-VsWAXCt_
X-Proofpoint-GUID: uSOCDu-RnnuaxYfRpDI6E_b-VsWAXCt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=432
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180174

I'm trying to do an allmodconfig build for ARCH=mips using:
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-mips-linux.tar.gz

This build dies quickly with:
  CC      scripts/mod/empty.o
cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor
cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor
  CC      scripts/mod/devicetable-offsets.s
make[2]: *** [scripts/Makefile.build:244: scripts/mod/empty.o] Error 1
make[2]: *** Waiting for unfinished jobs....
cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor
cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor
  HDRINST usr/include/linux/usb/tmc.h
make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1

I see the following in my .config:
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y

So I'll turn those off, but just want to flag that this issue exists.
Seems either the plugins should work or the allmodconfig should turn them off.

/jeff
