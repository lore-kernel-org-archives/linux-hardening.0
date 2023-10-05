Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83919347D8
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fL1WNVKg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E36F2062;
	Thu,  5 Oct 2023 09:27:32 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395GLUCv007476;
	Thu, 5 Oct 2023 16:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KB9WapbQCUe+n6Dn9WPhb6G7uBqrCMpzPZyxGOvBxUg=;
 b=fL1WNVKgU/HFChz5Nm3Ba3unjg8NsDnevWj0oqzkjVKQE3v+TMSiMVHEj7FNtk6A2bl1
 8qnwERDl+km18Cm9bydHEY5V8ex3Tetw3Q0HfOEzFXe6KoQWaFft/EZ6YAWZLo0DdyyA
 mu3BL6cU9RA9tmIVHD3vAQpkqzCegLH0BlPa11X7F69fkejx0Zkkt++vK9yD4Ek6OgnU
 ejZmgEcdjYy/iVT4AqdGNdp6tn6XQTZFZil+fwbHKby7qT/iJUvp87L+BRbidRfUAmPY
 /32b4ZbrQfSM0/RipNqdy8yo/g73S+A2m3K1bU5KL1eUvtUuak8gHKsXKsRhZXjc7YQd Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj0kb89s7-62
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Oct 2023 16:27:19 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395FeCiF009154;
	Thu, 5 Oct 2023 15:44:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thysxs3w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Oct 2023 15:44:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 395FWRCU007456;
	Thu, 5 Oct 2023 15:41:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygm4xfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Oct 2023 15:41:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 395FfSXO23986924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Oct 2023 15:41:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36B9E2004D;
	Thu,  5 Oct 2023 15:41:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9B502004B;
	Thu,  5 Oct 2023 15:41:27 +0000 (GMT)
Received: from [9.179.14.29] (unknown [9.179.14.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Oct 2023 15:41:27 +0000 (GMT)
Message-ID: <bf7a99b4-4679-4c99-b2c2-4aa17abaf0e0@linux.ibm.com>
Date: Thu, 5 Oct 2023 17:41:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gcov: Annotate struct gcov_iterator with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230922175220.work.327-kees@kernel.org>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20230922175220.work.327-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fo1ZpR0I3eHsucL4S3kJ3pj2j_pQlheY
X-Proofpoint-ORIG-GUID: LI4HhHRIfl4zVs38WQw3V6BnlAJby8l2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=677
 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1011 spamscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22.09.2023 19:52, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct gcov_iterator.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good to me!

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Andrew, could you add this patch via your tree?


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

