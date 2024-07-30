Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FA1DA32
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338145; cv=none; b=YuScUfkZEAnWC/wEhhYUweENOTZB7XJQKdjQZgsWm/cYHzZHEncxEHShpQKTO1BuLA5mg53H+bABk52eMleIjDPgzCOON8Md2Xx+WcZy2r4hAOWRZiVHhrZHj4U6V0Kvxuw8GDeuVcpIIxUrtLf5ctJczwerdp9rIAoJxRnVTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338145; c=relaxed/simple;
	bh=A1ouoj2biGMQThr4PHepsojMjdSPnXVszMLgNFuXnCI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bROESZ+6VX1mUra3w5KqRFx5/c61uiZqV7DPD25gg9Fd0psduBUQKRSNLUngdLHEDN7n8MGTOA+xqzWEtFow52EQZFbZ3LL+sw8Rw5sSqDZJVobmfZu81KVDABeV6Pc00I3TUQskF4Dt4C3INmlSYhEQMY4YTgARjI65tDDcrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COv0xXvx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COv0xXvx"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efa16aad9so6653414e87.0
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722338141; x=1722942941; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39EkPA8s762lsFZeJiSE8QLWkm2cKVXdZkhO3zFmhUk=;
        b=COv0xXvxYEzsKvBsTytI0e+nopT+60CvKP7qdnTRPdthp4m24+jXvdSjOImkjPm8Wh
         jnATYtk4LrSAwS6icqbCcjN31kb/TyVCBz/J1vouJiDko0y2cjW1azYPbeLZLDOFn+WL
         7dqKCRTW9q22Zhfn/ysPqSM7QrnoZWgCAp0pcRe8Bu0AGeKzV99Of916r82D9V41EKZW
         hlMLvWQYOvG0DODAAInzH7O+/ogB8+wdCbBChfchMHTt0irPrPKb15533fGth7lbDjlC
         On08GLHA+JAeuGRjotL6tHC3KI1OPX8Zdkj93B6NEftrWkRDIMiqyjSLm0681PEZbisD
         86mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722338141; x=1722942941;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39EkPA8s762lsFZeJiSE8QLWkm2cKVXdZkhO3zFmhUk=;
        b=HVUFUmfB2lNIQ2wSz4mSClZVNgrT+oPr42S363GkIMuvdSXCU1i/RUbzAm07SAIcyf
         hiVxvHPAt5wsoeDJBP3y9JYvwn9vaRDdQv1kSwcyrCJPkVJcCfcT9Qjd2tcsqMooW4Pj
         1HCLUpPRQcHq0/0V+1NrrUwpYq72i88jnroCZ0qz6RAsdUkaDLlUPGh50p2LnK5U+ezi
         2fy/bcYTrnNugT5hAptR0KVL/zXl1Gs8+xPahx7yrkCOea0AvNJqFaTJ0vHh7C7asV7b
         0UajWGNzOI4jBPI3A8tpCPwoLomZYqdWsD55pE43GKWHC/u2o6lhlP+xdH+Zm6t149ps
         56qQ==
X-Gm-Message-State: AOJu0YzFqtnBHKesasgJivSd7o0GJI+Cg3MUjNNeXdVDlucogAEK6vOS
	/kmsoCYsdUsQ/IqXs7BYu67zEjmwhdDNj4uqgTI+eFVoerK2Kdb7hC/0ysT4PfyzRvZrzu/po1i
	YbNs29SpkSqD2jmqVbsLV/1EJssq+nA1Q
X-Google-Smtp-Source: AGHT+IGtBNDWFB1UqmuVx+xjC7L9sbVIyptHGtucEBspeVdxXI+rNZKzLuzWmJVcH7BTyBCWowd0eS7E8ykPW3OV2cI=
X-Received: by 2002:a05:6512:4009:b0:52e:be1f:bf84 with SMTP id
 2adb3069b0e04-5309b2ce44bmr8236660e87.53.1722338141006; Tue, 30 Jul 2024
 04:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Prithivi Raj.S" <prithivi.s017@gmail.com>
Date: Tue, 30 Jul 2024 16:45:29 +0530
Message-ID: <CACBLJD=y-4aWa-7r-xhfYoTVEkQAGi2EmG3nA97rH2cz-KXmcw@mail.gmail.com>
Subject: Unexpected Heap Randomization Behavior in Kernel Version 5.10.216
To: linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have been testing Address Space Layout Randomization (ASLR)
functionalities with the kernel.randomize_va_space sysctl parameter.
According to the kernel documentation:

0 disables randomization.
1 randomizes the address of mmap base, stack, and VDSO page.
2 randomizes the heap address.

However, I have observed that in kernel version 5.10.216, the heap
base address is being randomized even when kernel.randomize_va_space
is set to 1. This behavior is not the same as described for this
parameter.

I tested this on an older kernel version (3.10.0) from the CentOS 7.9
distribution, where the feature worked as documented.

Test Code:

int main() {
    // Get the current end of the heap
    void *heap_addr = sbrk(0);

    printf("Current end of heap (base address): %p\n", heap_addr);

    return 0;
}

I would like to know if this behavior indicates a kernel bug or if the
heap address randomization is being influenced by other factors. This
is my first communication with the Linux community, so please let me
know if there is anything inappropriate or missing in my report. I am
happy to provide any additional information if needed.
