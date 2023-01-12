Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14786C54EBC
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 05:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjALFok (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 00:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjALFoi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 00:44:38 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA7FCFC
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jan 2023 21:44:37 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C4kaF4016905;
        Thu, 12 Jan 2023 05:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wYBXGs9KhcRW/sGzVt8WmWBlpWGKwJr2n5bDbpExY6k=;
 b=BSjAz84mX/MCg7ZaJp08Wdl8zHWthJgHu9+feC/1icXVhMhjmB5qMIuEgCynLJNmBQ/q
 HSZupu3YbmMv6fOduGIsCbvAb+x5CVY4Zn0fFYiTFbSC7uZu6sLYveYKsAFLEd3GJgnl
 KBlg4WGDiVyqKnAl0Zi2nm8rActSX2VOXxNqAu9qj9gMYDe1PJ+YI96d3utSjEY28vei
 p+DwLqWcL/3dIAgeROjLAVLKx00Yjf500xA/w/DJicjpkFNxeypzmMponiNb4aTHkYvH
 BAnEfcn4dQNm2UI/EEyZ/0KtjOkqK7ZhloiXj/cSHr+/pl2qwW/lTtEGOol8f5RRhjwd /w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2bfs8xq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 05:44:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30C3JbS7030869;
        Thu, 12 Jan 2023 05:44:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n1kf7hwas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 05:44:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30C5iWO343581788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 05:44:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE8C620043;
        Thu, 12 Jan 2023 05:44:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7257220040;
        Thu, 12 Jan 2023 05:44:31 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 05:44:31 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DF332600F7;
        Thu, 12 Jan 2023 16:44:26 +1100 (AEDT)
Message-ID: <5af2c54b767e2d314041dc77378c492ed44eaacf.camel@linux.ibm.com>
Subject: Re: Kernel Self-Protection Project meeting
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Date:   Thu, 12 Jan 2023 16:44:26 +1100
In-Reply-To: <202301110826.20083483E@keescook>
References: <202301110820.C6020B71EA@keescook>
         <202301110826.20083483E@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xFafsrmZo30HrPangax7g5BQpeZ4b23N
X-Proofpoint-ORIG-GUID: xFafsrmZo30HrPangax7g5BQpeZ4b23N
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_03,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=765 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120033
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

On Wed, 2023-01-11 at 08:27 -0800, Kees Cook wrote:
> On Wed, Jan 11, 2023 at 08:23:39AM -0800, Kees Cook wrote:
> > Hi!
> >=20
> > This is rather short notice; I'll send out a reminder further in
> > advance
> > next time, but if anyone would like to join our every-2-weeks
> > project
> > video conference, please drop in:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://meet.google.com=
/cuu-hqcm-ggg

This is a great idea!

Were there any notes taken from today's call?

>=20
> *cough* at 10am US Pacific today...

Is it anticipated that the meetings will consistently be at 10am
PST/PDT or will that move around a bit?

(I realise I'm a very quiet lurker on this list, but I am interested in
occasionally dropping in when I can; 10am PST is a bit tricky here in
+1100 territory but I'll still try.)


--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
