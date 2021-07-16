Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879A1C07E95
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Jul 2021 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA2E613F2
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Jul 2021 10:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbhGPKas (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Jul 2021 06:30:48 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:62888 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhGPKar (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Jul 2021 06:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1626431273; x=1657967273;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=QO0HV+dU7B/r2B65Dj8aQeD05OEFYAF1mdMcbVoqJA4=;
  b=aubX9DZ7AuLV59b25lz7RSMPJNGO0DAoo/j+ZUbPlKNa1cA3Vc8f0kOn
   bwqmt5IqYRRzl27iVyni0IqAa3yjtV8oTTObk9vYhWyEAtTAFjUmG0F/n
   Im29ZsJQnt5T0hnmtE4ojpTWC5iwiVNmm7oq2xdnCv+D609UMaOrmm6bX
   g=;
X-IronPort-AV: E=Sophos;i="5.84,244,1620691200"; 
   d="scan'208";a="944029449"
Subject: Re: Coverity Scan model file, license, public access
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-1e-c7f73527.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 16 Jul 2021 10:26:36 +0000
Received: from EX13D02EUB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7f73527.us-east-1.amazon.com (Postfix) with ESMTPS id 2FC74C016E;
        Fri, 16 Jul 2021 10:26:36 +0000 (UTC)
Received: from u6fc700a6f3c650.ant.amazon.com (10.43.161.69) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Fri, 16 Jul 2021 10:26:30 +0000
To:     Kees Cook <keescook@chromium.org>
CC:     Kroah-Hartman <greg@kroah.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        <linux-hardening@vger.kernel.org>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
 <YOSKuEcPoy/dw0st@kroah.com> <a41221c8-86e5-494d-68fd-0a0b87c99e83@amazon.de>
 <202107151111.23BA48F99@keescook>
From:   Norbert Manthey <nmanthey@amazon.de>
Message-ID: <0b18769a-dd84-8e39-b3a0-385a712381cd@amazon.de>
Date:   Fri, 16 Jul 2021 12:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107151111.23BA48F99@keescook>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.43.161.69]
X-ClientProxiedBy: EX13D11UWC001.ant.amazon.com (10.43.162.151) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

T24gNy8xNS8yMSA4OjI1IFBNLCBLZWVzIENvb2sgd3JvdGU6Cj4gQ0FVVElPTjogVGhpcyBlbWFp
bCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBz
ZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4KPiAKPiAKPiAKPiBPbiBUaHUsIEp1
bCAxNSwgMjAyMSBhdCAwMzoxMjowNFBNICswMjAwLCBOb3JiZXJ0IE1hbnRoZXkgd3JvdGU6Cj4+
IE9uIDcvNi8yMSA2OjU0IFBNLCBLcm9haC1IYXJ0bWFuIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiBU
dWUsIEp1bCAwNiwgMjAyMSBhdCAwOTo0NTo0N0FNICswMjAwLCBOb3JiZXJ0IE1hbnRoZXkgd3Jv
dGU6Cj4+Pj4gRGVhciBhbGwsCj4+Pj4KPj4+PiBJIHdvdWxkIGxpa2UgdG8gd29yayB3aXRoIGNv
ZGUgYW5hbHlzaXMgb24gdGhlIExpbnV4IGtlcm5lbC4gVGhlCj4+Pj4gY3VycmVudGx5IHVzZWQg
Q292ZXJpdHkgc2V0dXAgYWxyZWFkeSB1c2VzIGEgbW9kZWwgZmlsZSBbMV0gdG8gaW1wcm92ZQo+
Pj4+IHRoZSBwcmVjaXNpb24gb2YgdGhlIGFuYWx5c2lzLiBUbyB0aGUgYmVzdCBvZiBteSBrbm93
bGVkZ2UsIHRoaXMgbW9kZWwKPj4+PiBmaWxlIGlzIGN1cnJlbnRseSBub3QgcHVibGljbHkgYWNj
ZXNzaWJsZS4gSSBkaWQgbm90IGZpbmQgYSBsaWNlbnNlCj4+Pj4gYXR0YWNoZWQgdG8gIFsxXSwg
bm9yIGFueSBpbmZvcm1hdGlvbiBhYm91dCBsaWNlbnNpbmcuCj4+Pgo+Pj4gSSBoYXZlIG5vIGlk
ZWEgd2hvIHdyb3RlIHRoYXQgdGhpbmcsIHNvcnJ5Lgo+Pgo+PiBJcyB0aGVyZSBhbnlib2R5IGVs
c2Ugd2hvIGtub3dzIG1vcmUgYWJvdXQgdGhlIGhpc3Rvcnkgb2YgdGhlIHVzZWQKPj4gQ292ZXJp
dHkgbW9kZWw/IFRoYW5rcy4KPiAKPiBBcyBmYXIgYXMgSSBrbm93LCB0aGUgbW9kZWwgd2FzIHdy
aXR0ZW4gb3JpZ2luYWxseSBieSBEYXZlIEpvbmVzLCB3aXRoCj4gZnVydGhlciBjaGFuZ2VzIGZy
b20gbXlzZWxmIGFuZCwgSSB0aGluaywgQ29saW4gSWFuIEtpbmcuCj4gCj4gSSB0aG91Z2h0IGl0
IHdhcyB2aXNpYmxlIHRocm91Z2ggdGhlIENvdmVyaXR5IGRhc2hib2FyZCwgb25jZSB5b3UncmUK
PiBsb2dnZWQgaW46Cj4gaHR0cHM6Ly9zY2FuLmNvdmVyaXR5LmNvbS9wcm9qZWN0cy9saW51eC1u
ZXh0LXdlZWtseS1zY2FuP3RhYj1hbmFseXNpc19zZXR0aW5ncwo+IChTZWUgJ01vZGVsaW5nIGZp
bGUgbG9hZGVkIFtWaWV3XScpCj4gCj4gUmVnYXJkbGVzcywgSSBrZWVwIGEgY29weSBpbiBnaXQg
c2luY2UgSSdkIGJlZW4gdHdlYWtpbmcgaXQgKG1vc3RseSB0bwo+IG5vIG1lYW5pbmdmdWwgYmVu
ZWZpdDogdGhlIG1vZGVsIGZpbGUgZG9lc24ndCB3b3JrIHdpdGggbWFjcm9zLCB3aGljaCBpcwo+
IHdoZXJlIHRoZSBidWxrIG9mIHRoZSBmYWxzZSBwb3NpdGl2ZXMgaW4gQ292ZXJpdHkgY29tZSBm
cm9tKToKPiBodHRwczovL2dpdGh1Yi5jb20va2Vlcy9jb3Zlcml0eS1saW51eAoKVGhhbmtzISBU
aGlzIHJlcG8gY29tZXMgd2l0aCBhIGxpY2Vuc2UsIHNvIEkgY2FuIHN0YXJ0IGZyb20gdGhlcmUu
CgpCZXN0LApOb3JiZXJ0CgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJI
CktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlh
biBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENo
YXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAy
ODkgMjM3IDg3OQoKCg==

